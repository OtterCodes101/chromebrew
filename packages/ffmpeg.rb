require 'package'

class Ffmpeg < Package
  description 'Complete solution to record, convert and stream audio and video'
  homepage 'https://ffmpeg.org/'
  version '6.0-067ed53'
  license 'LGPL-2,1, GPL-2, GPL-3, and LGPL-3' # When changing ffmpeg's configure options, make sure this variable is still accurate.
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://git.ffmpeg.org/ffmpeg.git'
  git_hashtag '067ed535f47373927e8bc2ff8eec2c18014197e5'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ffmpeg/6.0-067ed53_armv7l/ffmpeg-6.0-067ed53-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ffmpeg/6.0-067ed53_armv7l/ffmpeg-6.0-067ed53-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ffmpeg/6.0-067ed53_x86_64/ffmpeg-6.0-067ed53-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '56858c30974397fae2b2ad18d6fb5d87fb712342e7b22c3c3c02649bfa7bb628',
     armv7l: '56858c30974397fae2b2ad18d6fb5d87fb712342e7b22c3c3c02649bfa7bb628',
     x86_64: 'db56222b5f9f498b0aa026c559ca805891bf3809ed6943978b69da52bafdf67f'
  })

  depends_on 'alsa_lib' # R
  depends_on 'avisynthplus' # ?
  depends_on 'bz2' # R
  depends_on 'ccache' => :build
  depends_on 'chromaprint' # ?
  depends_on 'dav1d' # R
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'fribidi' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gsm' # R
  depends_on 'harfbuzz'
  depends_on 'intel_media_sdk' if ARCH == 'x86_64' && CREW_IS_INTEL # R
  depends_on 'jack' # R
  depends_on 'ladspa' # ?
  depends_on 'leptonica' # R
  depends_on 'libaom' # R
  depends_on 'libass' # R
  depends_on 'libavc1394' # R
  depends_on 'libbluray' # R
  depends_on 'libdc1394' => :build
  depends_on 'libdrm' # R
  depends_on 'libfdk_aac' => :build
  depends_on 'libfdk_aac' # R
  depends_on 'libfrei0r' => :build
  depends_on 'libglvnd' # R
  depends_on 'libiec61883' # R
  depends_on 'libjpeg' # R
  depends_on 'libjxl' # R
  depends_on 'libmfx' if ARCH == 'i686' && CREW_IS_INTEL # R
  depends_on 'libmodplug' # R
  depends_on 'libmp3lame' # R
  depends_on 'libopencoreamr' # R
  depends_on 'libraw1394' # R
  depends_on 'libsdl2' # R
  depends_on 'libsoxr' # R
  depends_on 'libssh' # R
  depends_on 'libtheora' # R
  depends_on 'libva' # R
  depends_on 'libvdpau' # R
  depends_on 'libvoamrwbenc' => :build
  depends_on 'libvorbis' # R
  depends_on 'libvpx' # R
  depends_on 'libwebp' # R
  depends_on 'libx11' # R
  depends_on 'libx264' # R
  depends_on 'libx265' # R
  depends_on 'libxcb' # R
  depends_on 'libxext' # R
  depends_on 'libxml2' # R
  depends_on 'libxvid' # R
  depends_on 'libxv' # R
  depends_on 'lilv' # R
  depends_on 'mesa' # R
  depends_on 'nasm' => :build
  depends_on 'openal' # ?
  depends_on 'openjpeg' # R
  depends_on 'openmp' # R
  depends_on 'openssl' # R
  depends_on 'opus' # R
  depends_on 'pipewire' # R
  depends_on 'pulseaudio' # R
  depends_on 'rav1e' # R
  depends_on 'rtmpdump' # R
  depends_on 'rubberband' # R
  depends_on 'serd' # R
  depends_on 'snappy' # R
  depends_on 'sord' # R
  depends_on 'speex' # R
  depends_on 'sratom' # R
  depends_on 'srt' # R
  depends_on 'tesseract' # R
  depends_on 'v4l_utils' # R
  depends_on 'vidstab' # R
  depends_on 'vmaf' # R
  depends_on 'wavpack' # ?
  depends_on 'xzutils' # R
  depends_on 'zeromq' # R
  depends_on 'zimg' # R
  depends_on 'zlibpkg' # R
  depends_on 'zvbi' # R

  no_env_options if %w[aarch64 armv7l].include? ARCH

  def self.patch
    # Needed for qtwebengine compatibility.
    downloader 'https://github.com/archlinux/svntogit-packages/raw/packages/ffmpeg/trunk/add-av_stream_get_first_dts-for-chromium.patch',
               '57e26caced5a1382cb639235f9555fc50e45e7bf8333f7c9ae3d49b3241d3f77'
    system 'patch -Np1 -i add-av_stream_get_first_dts-for-chromium.patch'
  end

  def self.build
    case ARCH
    when 'i686'
      @mfx = '--enable-libmfx'
      @lto = ''
      @enablelto = ''
      @arch_cflags = ''
    when 'x86_64'
      @mfx = '--enable-libmfx'
      @lto = '-flto=auto'
      @enablelto = '--enable-lto'
      @arch_cflags = ''
    when 'aarch64', 'armv7l'
      @mfx = ''
      @lto = '-flto=auto'
      @enablelto = '--enable-lto'
      @arch_cflags = '-mfloat-abi=hard -mthumb -mfpu=neon -march=armv7-a+fp'
    end

    # ChromeOS awk employs sandbox redirection protections which screw
    # up configure script generation, so use mawk.
    system "sed -i 's/awk/mawk/g' configure"
    system "CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE #{@lto} -fuse-ld=#{CREW_LINKER} #{@arch_cflags}' \
        CXXFLAGS='-pipe -U_FORTIFY_SOURCE #{@lto} -fuse-ld=#{CREW_LINKER} #{@arch_cflags}' \
        LDFLAGS='-U_FORTIFY_SOURCE #{@lto}' \
        ./configure \
        --arch=#{ARCH} \
        --disable-debug \
        --disable-doc \
        --disable-iconv \
        --enable-avfilter \
        --enable-avisynth \
        --enable-ffplay \
        --enable-fontconfig \
        --enable-frei0r \
        --enable-gmp \
        --enable-gpl \
        --enable-ladspa \
        --enable-libaom \
        --enable-libass \
        --enable-libbluray \
        --enable-libdav1d \
        --enable-libdrm \
        --enable-libfdk-aac \
        --enable-libfontconfig \
        --enable-libfreetype \
        --enable-libfribidi \
        --enable-libgsm \
        --enable-libiec61883 \
        --enable-libjack \
        --enable-libjxl \
        --enable-libmodplug \
        --enable-libmp3lame \
        --enable-libopencore_amrnb \
        --enable-libopencore_amrwb \
        --enable-libopenjpeg \
        --enable-libopus \
        --enable-libpulse \
        --enable-librav1e \
        --enable-librtmp \
        --enable-librubberband \
        --enable-libsnappy \
        --enable-libsoxr \
        --enable-libspeex \
        --enable-libsrt \
        --enable-libssh \
        --enable-libtesseract \
        --enable-libtheora \
        --enable-libv4l2 \
        --enable-libvidstab \
        --enable-libvmaf \
        --enable-libvorbis \
        --enable-libvpx \
        --enable-libwebp \
        --enable-libx264 \
        --enable-libx265 \
        --enable-libxcb \
        --enable-libxml2 \
        --enable-libxvid \
        --enable-libzimg \
        --enable-libzmq \
        --enable-libzvbi \
        #{@enablelto} \
        --enable-lv2 \
        --enable-lzma \
        --enable-nonfree \
        --enable-opengl \
        --enable-openssl \
        --enable-pthreads \
        --enable-shared \
        --enable-version3 \
        #{@mfx}  \
        --host-cflags='-pipe -fno-stack-protector -U_FORTIFY_SOURCE #{@lto} -fuse-ld=#{CREW_LINKER} #{@arch_cflags}' \
        --host-ldflags='-fno-stack-protector -U_FORTIFY_SOURCE #{@lto} #{@arch_cflags}' \
        #{CREW_OPTIONS.sub(/--build=.*/, '').gsub('vfpv3-d16', 'neon')}"

    system "env PATH=#{CREW_LIB_PREFIX}/ccache/bin:#{CREW_PREFIX}/bin:/usr/bin:/bin \
        make -j#{CREW_NPROC}"
    system 'make tools/qt-faststart'
    system 'make doc/ffmpeg.1'
    system 'make doc/ffplay.1'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.install 'tools/qt-faststart', "#{CREW_DEST_PREFIX}/bin/", mode: 0o755
    FileUtils.install Dir.glob('doc/ff*.1'), "#{CREW_DEST_MAN_PREFIX}/man1/", mode: 0o644
  end
end
