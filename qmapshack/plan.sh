pkg_origin=

pkg_name=qmapshack
pkg_version=1.8.1
pkg_description="Plan your next outdoor trip or to visualize and archive all the GPS recordings, next generation of the QLandkarte GT application"
pkg_upstream_url="https://bitbucket.org/maproom/qmapshack/wiki/Home"
pkg_license=('GPL')
pkg_deps=('gdal' 'gpsd' 'libdmtx' 'libexif' 'libmariadbclient' 'mesa' 'postgresql-libs'
         'shared-mime-info' 'unixodbc' 'glu' 'qt5-webkit' 'proj' 'qt5-script' 
         'routino' 'quazip')
pkg_build_deps=('cmake' 'extra-cmake-modules' 'qt5-tools')
pkg_source=("https://bitbucket.org/maproom/qmapshack/downloads/${pkg_name}-${pkg_version}.tar.gz"
        'qnetworkreply.diff')
pkg_shasum=('efff7150d4ef061fba9279c66feed077'
         'cebaa7d97f1dca2a5abb2b54ab37e67f')

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  
  patch -p1 -i ${CACHE_PATH}/qnetworkreply.diff
}

do_build() {
  mkdir -p build
  cd build
 
  cmake ../${pkg_name}-${pkg_version} \
      -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_BUILD_TYPE=Release 
      
  make
}

do_package(){
  cd build
  make DESTDIR=${pkg_prefix} install
  
  install -Dm644 ../${pkg_name}-${pkg_version}/LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
