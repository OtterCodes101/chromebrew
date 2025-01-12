require 'buildsystems/python'

class Py3_agate_sql < Python
  description 'Agate-sql adds SQL read/write support to agate.'
  homepage 'https://agate-sql.readthedocs.org/'
  @_ver = '0.6.0'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/wireservice/agate-sql.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_sql/0.6.0-py3.12_armv7l/py3_agate_sql-0.6.0-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_sql/0.6.0-py3.12_armv7l/py3_agate_sql-0.6.0-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_sql/0.6.0-py3.12_i686/py3_agate_sql-0.6.0-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_sql/0.6.0-py3.12_x86_64/py3_agate_sql-0.6.0-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '34fc4abae0696830075a13f982488fb5991e6063d912b488a14c91c2671b980c',
     armv7l: '34fc4abae0696830075a13f982488fb5991e6063d912b488a14c91c2671b980c',
       i686: 'c6bccfa1b69d9262be9fa6325335e1b9eb1bb141a1d676fd4a5695939578feaa',
     x86_64: 'd861ecdf04c1445cad0e49d98a00815660e72088deb7aa8015c4b6d671007941'
  })

  depends_on 'py3_agate'
  depends_on 'py3_sqlalchemy'
  depends_on 'python3' => :build
end
