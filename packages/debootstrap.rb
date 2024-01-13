require 'package'

class Debootstrap < Package
  description 'Bootstrap a basic Debian system'
  homepage 'https://packages.debian.org/bookworm/debootstrap'
  version '1.0.128'
  license 'MIT'
  compatibility 'all'
  depends_on 'wget2'
  depends_on 'gnupg'
  binary_url 'http://http.us.debian.org/debian/pool/main/d/debootstrap/debootstrap_1.0.128+nmu2+deb12u1_all.deb'
  binary_sha256 'bd3cd2c76625e9038d5eb08813afc101dd0a5b9edd4388ef76d15358abcc6dc6'
end
