pkg_origin=

pkg_name=heaptrack
pkg_version=1.0.0
pkg_description='A heap memory profiler for Linux'
pkg_upstream_url="https://github.com/KDE/heaptrack"
pkg_license=('GPL')
pkg_deps=('boost-libs' 'libunwind' 'elfutils' 'kcoreaddons' 'ki18n' 'kitemmodels' 'threadweaver'
         'kio' 'kconfigwidgets' 'kdiagram' 'sparsehash')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'boost')
pkg_source=("https://download.kde.org/stable/heaptrack/${pkg_version}/src/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('6fe8c891b8b8f7af7672072ef80889ff')

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  
  #patch -p1 -i $CACHE_PATH/bluezqt5.11.patch
}
         
do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr 
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
