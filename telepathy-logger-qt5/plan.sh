pkg_origin=

pkg_name=telepathy-logger-qt5
_pkg_name=telepathy-logger-qt
pkg_version=15.04.0
_pkg_version=15.04
pkg_description="Qt Wrapper around TpLogger client library."
pkg_upstream_url="https://projects.kde.org/projects/extragear/network/telepathy/telepathy-logger-qt"
pkg_license=('GPL')
pkg_deps=('telepathy-qt5' 'qt5-gstreamer' 'telepathy-logger' 'boost-libs')
pkg_build_deps=('extra-cmake-modules' 'python2' 'boost' 'doxygen')
group=('kde-telepathy')
pkg_source=("http://download.kde.org/stable/telepathy-logger-qt/${_pkg_version}/src/${_pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('d5f2811952c7a514a733dacd190b5f3b')

do_prepare() {
  cd ${_pkg_name}-${pkg_version}
  #sed -i -e 's|QtGLib|Qt5GLib|' ${CACHE_PATH}/${_pkg_name}/CMakeLists.txt
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${_pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DPYTHON_EXECUTABLE=/usr/bin/python2
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix}/ install
}
