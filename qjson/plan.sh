pkg_origin=

pkg_name=qjson
pkg_version=0.9.0
_commit=eee8a1626f18499a95a5216dd1832f45c15a46ba
pkg_description="A qt-based library that maps JSON data to QVariant objects."
pkg_license=('GPL')
pkg_upstream_url="http://qjson.sourceforge.net"
pkg_deps=('qt5-base')
pkg_build_deps=('cmake' 'git')
pkg_source=("https://github.com/flavio/qjson/archive/${_commit}.zip")
pkg_shasum=('8252d203dc2376b760283ec685ae145c')


do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${_commit} \
    -DCMAKE_INSTALL_PREFIX=/usr
  make 
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install 
}
