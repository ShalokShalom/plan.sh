pkg_origin=cosmos

pkg_name=libmygpo-qt
pkg_version=1.0.9
pkg_description="A C++/Qt client library for gpodder.net"
pkg_upstream_url="http://wiki.gpodder.org/wiki/Libmygpo-qt"
pkg_license=('LGPL2.1')
pkg_deps=('qt5-base')
pkg_build_deps=('cmake')
pkg_source=("https://github.com/gpodder/libmygpo-qt/archive/${pkg_version}.tar.gz")
pkg_shasum=('292ec83a482103cd690d13509bc0622c')

do_build() {
  mkdir -p build
  
  cmake ../${pkg_name}-${pkg_version}  \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DBUILD_WITH_QT4=OFF
  make
}

do_package(){
  
  make DESTDIR=${pkg_prefix} install
}
