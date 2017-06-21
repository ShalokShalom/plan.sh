pkg_origin=cosmos

pkg_name=taglib-extras
pkg_version=1.0.1
pkg_description="Additional taglib plugins for KDE"
pkg_upstream_url="http://developer.kde.org/~wheeler/taglib.html"
pkg_license=('LGPL')
pkg_deps=('taglib')
pkg_build_deps=('pkgconfig' 'extra-cmake-modules')
pkg_source=("http://sourceforge.net/projects/kaosx/files/sources/taglib-extras/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('e973ca609b18e2c03c147ff9fd9e6eb8')

do_prepare() {
   
  sed -i -e 's|(TAGLIB_VERSION STRLESS "${TAGLIB_MIN_VERSION}")|("${TAGLIB_MIN_VERSION}" VERSION_GREATER TAGLIB_VERSION)|' cmake/modules/FindTaglib.cmake
}

do_build() {
  mkdir -p build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_SKIP_RPATH=ON
  make
}

do_package() {
  
  make DESTDIR=${CACHE_PATH} install
}
