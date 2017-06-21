pkg_origin=

pkg_name=openimageio
_pkg_name=OpenImageIO
pkg_version=1.4.15
pkg_description="A library for reading and writing images, including classes, utilities, and applications."
pkg_upstream_url="http://www.openimageio.org/"
pkg_license=('custom')
pkg_deps=('openexr' 'boost-libs' 'jasper' 'glew' 'libtiff' 'opencolorio' 'qt')
pkg_build_deps=('cmake' 'python2' 'boost' 'mesa')
optpkg_deps=('python2: bindings support')
pkg_source=("https://github.com/OpenImageIO/oiio/archive/Release-${pkg_version}.tar.gz"
        'freetype.patch')
pkg_shasum=('8911cf6103e9fe3638912908bb4faa19'
         'b1a27daf910718d7a055daf5b0c4b534')

do_build() {
  cd $CACHE_PATH/oiio-Release-$pkg_version
  patch -p1 -i ${CACHE_PATH}/freetype.patch

  mkdir build 
  cd build
  cmake -DCMAKE_INSTALL_PREFIX=/usr \
      -DPYLIB_INSTALL_DIR=lib/python2.7/site-packages \
      -DOIIO_BUILD_TESTS=OFF \
      ..
  make
}

do_package() {
  cd $CACHE_PATH/oiio-Release-$pkg_version/build

  make DESTDIR=$pkg_prefix install

  # license
  cd ..
  install -Dm644 LICENSE "$pkg_prefix/usr/share/licenses/$pkg_name/LICENSE"
}
