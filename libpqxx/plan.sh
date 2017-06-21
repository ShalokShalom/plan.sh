pkg_origin=cosmos

pkg_name=libpqxx
pkg_version=5.0.1
pkg_description="C++ client API for PostgreSQL"
pkg_license=('custom')
pkg_upstream_url="http://pqxx.org/development/libpqxx/"
pkg_deps=('postgresql-libs')
pkg_build_deps=('python2' 'boost')
pkg_source=("https://github.com/jtv/libpqxx/archive/${pkg_version}.tar.gz")
pkg_shasum=('4fab40ed8b6d03897b98742ea6ce7418')

do_build() {

  ./configure --prefix=/usr --enable-shared
  make
}

do_package() {
  make prefix=${pkg_prefix}/usr install
  
  install -D -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
