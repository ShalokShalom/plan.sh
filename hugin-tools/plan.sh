pkg_origin=cosmos

pkg_name=hugin-tools
_pkg_name=hugin
pkg_version=2016.2.0
pkg_description="Hugin libs and tools to be used by Kipi-plugins"
pkg_upstream_url="http://hugin.sourceforge.net/"
pkg_license=('LGPL')
pkg_deps=('boost-libs' 'enblend-enfuse' 'exiv2' 'openexr' 'libpano13>=2.9.19'
         'lapack' 'desktop-file-utils' 'icu' 'libxt' 'lensfun' 'glew' 'image-exiftool')
pkg_build_deps=('zip' 'cmake' 'boost' 'mesa' 'tclap')
conflict=('hugin')
pkg_source=("http://downloads.sourceforge.net/hugin/${_pkg_name}-${pkg_version}.tar.bz2")
       # "http://downloads.sourceforge.net/boost/boost_1_55_0.tar.bz2")
pkg_shasum=('bfc28b0774e5147207e8b4b54875c33d')
        # 'd6eef4b4cacb2183f2bf265a5a03a354')

do_build() {
  mkdir -p build 

  # make it possible to compile all the hugin tools without GUis
  sed -i -e "s~FIND_PACKAGE(wxWidgets REQUIRED)~~g" ${CACHE_PATH}/${_pkg_name}-${pkg_version}/CMakeLists.txt
  
  cmake ../${_pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DENABLE_LAPACK=yes \
    -DBUILD_HSI=no
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  rm -f ${pkg_prefix}/usr/share/applications/pto_gen.desktop 
}
