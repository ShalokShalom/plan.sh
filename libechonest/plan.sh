pkg_origin=cosmos

pkg_name=libechonest
pkg_version=2.3.1
pkg_description="C++ library for interfacing with Echo Nest (builds the qt5 version)"
pkg_upstream_url="https://projects.kde.org/projects/playground/libs/libechonest"
pkg_license=('GPL')
pkg_deps=('qt5-base')
pkg_source=("https://github.com/lfranchi/libechonest/archive/2.3.1.tar.gz")
pkg_shasum=('c4f84633d9b2dc2097078ccb0e8eb50a')

prepare() {
  mkdir build
}

do_build() {

  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DECHONEST_BUILD_TESTS=OFF \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DBUILD_WITH_QT4=off
  make
}

do_package() {

  make DESTDIR="${pkg_prefix}" install
}
