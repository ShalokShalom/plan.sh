pkg_origin=

pkg_name=kbibtex
pkg_version=0.6.2
pkg_description="Editor for bibliographies used with LaTeX"
pkg_upstream_url="http://home.gna.org/kbibtex/"
pkg_license=('GPL2')
pkg_deps=('kcoreaddons' 'ki18n' 'kxmlgui' 'kio' 'kiconthemes' 'kitemviews' 'kcompletion' 'kparts' 'kservice'
         'kwallet' 'qca-qt5' 'poppler-qt5')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'icu')
pkg_source=("git://anongit.kde.org/kbibtex.git")
pkg_shasum=('SKIP')
 
do_build() { 
  mkdir -p build
  cd build

  cmake ../${pkg_name} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DSYSCONF_INSTALL_DIR=/etc \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
