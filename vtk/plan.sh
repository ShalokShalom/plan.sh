pkg_origin=

pkg_name=vtk
pkg_version=7.1.1
_pkg_version=7.1
pkg_description='Open-source software system for 3D computer graphics, image processing, and visualization.'
pkg_upstream_url='https://gitlab.kitware.com/vtk/vtk'
pkg_license=('BSD')
pkg_deps=('java-environment' 'gnuplot' 'tk' 'python2-matplotlib' 'unixodbc' 'gdal' 'openmpi' 'mariadb'
         'glew' 'gl2ps' 'ffmpeg' 'python2-six' 'qt5-tools' 'jsoncpp')
pkg_build_deps=('boost' 'cmake')
pkg_source=("http://www.vtk.org/files/release/${_pkg_version}/VTK-${pkg_version}.tar.gz"
        "http://www.vtk.org/files/release/${_pkg_version}/VTKData-${pkg_version}.tar.gz"
        "http://www.vtk.org/files/release/${_pkg_version}/VTKLargeData-${pkg_version}.tar.gz"
        'gdal2.patch')
pkg_shasum=('daee43460f4e95547f0635240ffbc9cb'
         '3a424d51e8407497ce5f783323ac9b46'
         '17d9996cf6382037d1bb0a03c855a68b'
         'e85edd330937a2395a233e0cb6be0b83')

do_prepare() {
  cd VTK-${pkg_version}

  #patch -p1 -i ${CACHE_PATH}/gdal2.patch
}

do_build() {
  mkdir build
  cd build

  #export JAVA_HOME=/usr/lib/jvm/default

  # use system libs
  local cmake_system_flags=""
  for lib in EXPAT FREETYPE JPEG PNG TIFF ZLIB OGGTHEORA SIX JSONCPP GLEW GL2PS; do
    cmake_system_flags+="-DVTK_USE_SYSTEM_${lib}:BOOL=ON "
  done

  cmake ../VTK-${pkg_version} \
    -Wno-dev \
    -DCMAKE_SKIP_RPATH=ON \
    -DBUILD_SHARED_LIBS:BOOL=ON \
    -DCMAKE_INSTALL_PREFIX:FILEPATH=/usr \
    -DBUILD_DOCUMENTATION:BOOL=OFF \
    -DDOCUMENTATION_HTML_HELP:BOOL=OFF \
    -DDOCUMENTATION_HTML_TARZ:BOOL=OFF \
    -DBUILD_EXAMPLES:BOOL=ON \
    -DVTK_USE_FFMPEG_ENCODER:BOOL=ON \
    -DVTK_BUILD_ALL_MODULES:BOOL=ON \
    -DVTK_USE_LARGE_DATA:BOOL=ON \
    -DVTK_QT_VERSION:STRING="5" \
    -DVTK_WRAP_JAVA:BOOL=ON \
    -DVTK_WRAP_PYTHON:BOOL=ON \
    -DVTK_WRAP_TCL:BOOL=ON \
    -DCMAKE_CXX_FLAGS="-D__STDC_CONSTANT_MACROS" \
    -DVTK_CUSTOM_LIBRARY_SUFFIX="" \
    -DVTK_INSTALL_INCLUDE_DIR:PATH=include/vtk \
    -DVTK_RENDERING_BACKEND="OpenGL" \
    ${cmake_system_flags} \
    -DCMAKE_BUILD_TYPE=Release 

  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install

  install -dv ${pkg_prefix}/usr/share/java/vtk
  mv -v ${pkg_prefix}/usr/lib/vtk.jar ${pkg_prefix}/usr/share/java/vtk
  #rm -rf ${pkg_prefix}/usr/lib/vtk-${_pkg_version}/java

  install -dv ${pkg_prefix}/usr/share/licenses/vtk
  install -m644 ${CACHE_PATH}/VTK-${pkg_version}/Copyright.txt ${pkg_prefix}/usr/share/licenses/vtk

  install -dv ${pkg_prefix}/usr/lib/qt5
  mv ${pkg_prefix}/usr/plugins ${pkg_prefix}/usr/lib/qt5/plugins
}

