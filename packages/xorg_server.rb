require 'package'

class Xorg_server < Package
  description 'The Xorg Server is the core of the X Window system.'
  homepage 'https://www.x.org'
  version '21.1.10'
  license 'BSD-3, MIT, BSD-4, MIT-with-advertising, ISC and custom'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/xorg/xserver.git'
  git_hashtag "xorg-server-#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_server/21.1.10_armv7l/xorg_server-21.1.10-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_server/21.1.10_armv7l/xorg_server-21.1.10-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_server/21.1.10_x86_64/xorg_server-21.1.10-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a9ef1edc061677e829132e250ed5c774c25a738dc06d5a2b4bd5e5f360614524',
     armv7l: 'a9ef1edc061677e829132e250ed5c774c25a738dc06d5a2b4bd5e5f360614524',
     x86_64: '08d117a7c5429a46e8d0886e9b7a6de7e751454cceb94721d7f1d852903f3961'
  })

  depends_on 'dbus' # R
  depends_on 'eudev' # R
  depends_on 'font_util' => :build
  depends_on 'glibc' # R
  depends_on 'glproto' => :build
  depends_on 'graphite' => :build
  depends_on 'libbsd' # R
  depends_on 'libdrm' # R
  depends_on 'libepoxy' # R
  depends_on 'libglvnd' # R
  depends_on 'libinput' => :build
  depends_on 'libmd' # R
  depends_on 'libpciaccess' # R
  depends_on 'libtirpc' # R
  depends_on 'libunwind' => :build
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxcvt' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxext' # R
  depends_on 'libxfont2' # R
  depends_on 'libxfont' => :build
  depends_on 'libxfont' # R
  depends_on 'libxkbcommon' => :build
  depends_on 'libxkbfile' # R
  depends_on 'libxshmfence' # R
  depends_on 'libxtrans' => :build
  depends_on 'lzma' => :build
  depends_on 'mesa' # R
  depends_on 'pixman' # R
  depends_on 'xcb_util_cursor' => :build
  depends_on 'xcb_util_image' # R
  depends_on 'xcb_util_keysyms' # R
  depends_on 'xcb_util' # R
  depends_on 'xcb_util_renderutil' # R
  depends_on 'xcb_util_wm' # R
  depends_on 'xcb_util_xrm' => :build
  depends_on 'xkbcomp' => :build
  depends_on 'xorg_proto' => :build

  def self.build
    system 'meson setup build'
    system "meson configure #{CREW_MESON_OPTIONS.sub(/(-Dcpp_args='*)(.*)(')/, '')} \
              -Db_asneeded=false \
              -Dipv6=true \
              -Dxvfb=true \
              -Dxnest=true \
              -Dxcsecurity=true \
              -Dxorg=true \
              -Dxephyr=true \
              -Dglamor=true \
              -Dudev=true \
              -Dxwin=false \
              -Dsystemd_logind=false \
              -Dint10=auto \
              -Dlog_dir=#{CREW_PREFIX}/var/log \
              build"
    system 'ninja -C build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
    # Get these from xwayland package
    @deletefiles = %W[#{CREW_DEST_PREFIX}/bin/Xwayland #{CREW_DEST_LIB_PREFIX}/xorg/protocol.txt]
    @deletefiles.each do |f|
      FileUtils.rm_f f
    end
  end
end
