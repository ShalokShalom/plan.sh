pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kdebugsettings
pkg_version=${_kdever}
#pkg_version=15.03.70
pkg_description="Archiver for various compression formats"
pkg_upstream_url="http://www.kde.org"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kcoreaddons' 'kconfig' 'kconfigwidgets' 'kdbusaddons' 'ki18n' 'kguiaddons' 'kiconthemes'
         'kwidgetsaddons' 'kitemviews' 'kcompletion' 'kio')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'git')
pkg_source=($_mirror/${pkg_name}-$_kdever.tar.xz)
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
#pkg_source=("git://anongit.kde.org/kdebugsettings.git")
#pkg_shasum=('SKIP')

do_build() {
  cd ${CACHE_PATH}
  
  mkdir -p build
  cd build

  cmake ../${pkg_name}-$_kdever \
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
