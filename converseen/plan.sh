pkg_origin=

pkg_name=converseen
pkg_version=0.9.6.2
pkg_description="Open source image converter and resizer written in C++ with the powerful Qt5 libraries"
pkg_upstream_url="http://converseen.fasterland.net/"
pkg_license=('GPL3')
pkg_deps=('imagemagick' 'qt5-base' 'libwebp' 'openexr')
pkg_build_deps=('qt5-tools')
pkg_source=("https://github.com/Faster3ck/Converseen/archive/v${pkg_version}.tar.gz")
pkg_shasum=('c71f7364dacf702cdffee492f1817f93')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../Converseen-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr
    
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
