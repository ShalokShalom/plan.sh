pkg_origin=cosmos

pkg_name=libkolab
pkg_version=1.0.2
pkg_description="Advanced Kolab Object Handling Library"
pkg_upstream_url='http://kolab.org/'
pkg_license=('GPL')
pkg_deps=('libkolabxml' 'akonadi-contacts' 'akonadi-notes' 'kcalutils')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'boost')
pkg_source=("http://mirror.kolabsys.com/pub/releases/${pkg_name}-${pkg_version}.tar.gz")
#pkg_source=("http://git.kolab.org/libkolab/snapshot/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('312f35920989fd115386ee256fe78ba2')

prepare() {
  
    #patch -p1 -i $CACHE_PATH/D41.diff
}
         
do_build() {
  mkdir build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_SKIP_RPATH=ON \
    -DCMAKE_INSTALL_PREFIX=/usr
  make
}

do_package() {
  
  make DESTDIR="${pkg_prefix}" install
}
