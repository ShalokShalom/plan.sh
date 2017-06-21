pkg_origin=

pkg_name=oce
pkg_version=0.17
epoch=1
pkg_description="Open CASCADE Community Edition, 3D modeling & numerical simulation"
pkg_upstream_url="https://github.com/tpaviot/oce"
pkg_license=('custom')
pkg_deps=('tk' 'mesa' 'libxmu' 'ftgl' 'vtk' 'openmpi')
pkg_build_deps=('cmake')
pkg_source=("https://github.com/tpaviot/oce/archive/OCE-${pkg_version}.tar.gz"
        'opencascade-draw.desktop'
        'oce.png')
pkg_shasum=('f1a89395c4b0d199bea3db62b85f818d')

do_prepare() {
  cd ${pkg_name}-OCE-${pkg_version}
  
  #sed -i -e 's|-6.1||' adm/cmake/TKIVtk/CMakeLists.txt
}
         
do_build() {
  mkdir -p build
  cd build
  
  CXXFLAGS+=' -DvtkFloatingPointType=double'

  cmake ../${pkg_name}-OCE-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DOCE_INSTALL_PREFIX=/usr \
    -DOCE_INSTALL_LIB_DIR=/usr/lib \
    -DOCE_DRAW=ON \
    -OCE_WITH_GL2PS=ON \
    -DOCE_WITH_VTK=ON \
    -DOCE_MULTITHREAD_LIBRARY:STRING=OPENMP \
    -DCMAKE_SKIP_RPATH=FALSE 
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
  
  install -dm755 $pkg_prefix/usr/share/licenses/${pkg_name}/
  install -m644 ${CACHE_PATH}/${pkg_name}-OCE-${pkg_version}/LICENSE_LGPL_21.txt  ${pkg_prefix}/usr/share/licenses/${pkg_name}
  install -m644 ${CACHE_PATH}/${pkg_name}-OCE-${pkg_version}/OCCT_LGPL_EXCEPTION.txt ${pkg_prefix}/usr/share/licenses/${pkg_name}
  
  install -Dm644 ${CACHE_PATH}/opencascade-draw.desktop ${pkg_prefix}/usr/share/applications/opencascade-draw.desktop 
  install -Dm644 ${CACHE_PATH}/oce.png ${pkg_prefix}/usr/share/pixmaps/oce.png
}

