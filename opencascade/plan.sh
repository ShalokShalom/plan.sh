pkg_origin=

pkg_name=opencascade
pkg_version=7.1.0
_commit=8ae442a8cbcd50d4c59a7024b198646123387579
epoch=1
pkg_description="Open CASCADE Technology, 3D modeling & numerical simulation"
pkg_upstream_url="http://dev.opencascade.org/"
pkg_license=('custom')
pkg_deps=('tk' 'mesa' 'java-runtime' 'libxmu' 'ftgl' 'vtk' 'qtwebkit-tp')
pkg_build_deps=('java-environment' 'cmake')
pkg_source=("opencascade-${pkg_version}.tar.gz::http://git.dev.opencascade.org/gitweb/?p=occt.git;a=snapshot;h=${_commit};sf=tgz"
        'env.sh'
        'opencascade.sh'
        'opencascade.conf'
        'cmake.patch')
pkg_shasum=('87b278a073f6e35cd7d3fb6ff425e061'
         'a96f28ee7f4273ae1771ee033a2a3af3'
         'd9368b8d348ced3ec4462012977552d2'
         '2924ecf57c95d25888f51071fdc72ad0'
         '0424cd6d6f8ce1a96b9883ef229b7048')

do_prepare() {
  cd occt-8ae442a
  
  patch -p1 -i ${CACHE_PATH}/cmake.patch
  #sed -i -e 's|-6.1||' adm/cmake/TKIVtkDraw/CMakeLists.txt
}
         
do_build() {
  cd occt-8ae442a
  mkdir -p build
  cd build
  
  #CXXFLAGS+=' -DvtkFloatingPointType=double'

  cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/opt/${pkg_name} \
    -DINSTALL_DIR=/opt/${pkg_name} \
    -DCMAKE_INSTALL_RPATH=/opt/${pkgbase}/lib \
    -DINSTALL_FREETYPE=/opt/${pkg_name} \
    -DINSTALL_TCL=/opt/${pkg_name} \
    -D3RDPARTY_GL2PS_DIR= \
    -DUSE_VTK=ON
  make
}

do_package() {
  cd occt-8ae442a/build
  make DESTDIR=${pkg_prefix} install
  
  #cp -r src/UnitsAPI/ "${pkg_prefix}/opt/${pkg_name}/src"
  install -D -m644 ${CACHE_PATH}/opencascade.conf ${pkg_prefix}/etc/ld.so.conf.d/opencascade.conf
  install -D -m 755 ${CACHE_PATH}/opencascade.sh ${pkg_prefix}/etc/profile.d/opencascade.sh
  install -m 755 ${CACHE_PATH}/env.sh ${pkg_prefix}/opt/${pkg_name}
  
  install -dm755 $pkg_prefix/usr/share/licenses/${pkg_name}/
  install -m644 ${CACHE_PATH}/${pkg_name}-${pkg_version}/LICENSE_LGPL_21.txt  ${pkg_prefix}/usr/share/licenses/${pkg_name}
  install -m644 ${CACHE_PATH}/${pkg_name}-${pkg_version}/OCCT_LGPL_EXCEPTION.txt ${pkg_prefix}/usr/share/licenses/${pkg_name}
}

