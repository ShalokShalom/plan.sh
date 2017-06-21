pkg_origin=cosmos

pkg_name=libkolabxml
pkg_version=1.1.6
pkg_description="Kolab XML Format Schema Definitions Library"
pkg_upstream_url='http://git.kolab.org/libkolabxml/'
pkg_license=('GPL')
pkg_deps=('xerces-c' 'boost-libs') # 'qt5-base' 'kdelibs4support')
pkg_build_deps=('extra-cmake-modules' 'boost' 'xsd' 'swig')
pkg_source=("http://mirror.kolabsys.com/pub/releases/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('eec4b8bf117a6e263eed9ee800ae3aa6')

do_build() {
  mkdir build

  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DBUILD_TESTS=OFF
    #-DQT5_BUILD=TRUE
  make
}

do_package() {

  make DESTDIR="${pkg_prefix}" install
}
