pkg_origin=

pkg_name=darktable
pkg_version=2.2.5
_pkg_version=2.2.5
pkg_description="Open source photography workflow application and RAW developer"
pkg_upstream_url="http://darktable.sf.net/"
pkg_license=('GPL3')
pkg_deps=('exiv2' 'intltool' 'lcms2' 'lensfun' 'libglade' 'dbus-glib' 'curl' 'kwallet'
         'libgphoto2' 'openexr' 'sqlite' 'libxslt' 'libsoup' 'json-glib' 'flickcurl' 'librsvg'
         'colord' 'graphicsmagick' 'libwebp' 'gtk3' 'pugixml' 'openjpeg')
pkg_build_deps=('cmake')
pkg_source=("https://github.com/darktable-org/darktable/releases/download/release-${pkg_version}/darktable-${_pkg_version}.tar.xz")
pkg_shasum=('6e1de7e7c26d9baa7bea7ba157400a2c')

do_build() {
  mkdir -p build
  cd build
  
  CXXFLAGS+=" -fpermissive"
  cmake ../${pkg_name}-${_pkg_version} \
      -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_BUILD_TYPE=Release \
      -DBINARY_PACKAGE_BUILD=1 \
      -DBUILD_USERMANUAL=False \
      -DDONT_USE_INTERNAL_LUA=Off \
      -DUSE_COLORD=On 
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
