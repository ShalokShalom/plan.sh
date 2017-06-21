pkg_origin=

pkg_name=audiothumbs
_pkg_name=audiothumbs-frameworks
pkg_version=0.2
pkg_description="Thumbnail generator for audio files, ported to KF5."
pkg_upstream_url="https://github.com/eplightning/audiothumbs-frameworks"
pkg_license=('LGPL')
pkg_deps=('taglib' 'kio' 'flac')
pkg_build_deps=('extra-cmake-modules' 'git')
pkg_source=("git://github.com/eplightning/${_pkg_name}.git")
pkg_shasum=('SKIP')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${_pkg_name} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
