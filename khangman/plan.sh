pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=khangman
pkg_version=${_kdever}
pkg_description="Hangman Game"
pkg_upstream_url="http://kde.org/applications/education/khangman/"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('ki18n' 'kcrash' 'kcompletion' 'kconfig' 'kcoreaddons' 'kconfigwidgets' 'kio' 'knewstuff' 
         'knotifications' 'kxmlgui' 'kdeedu-data' 'libkeduvocdocument' 'phonon-qt5' 'kdeclarative')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_prepare() {
  cd $pkg_name-${pkg_version}
  #sed -i -e 's|add_subdirectory( doc )|#add_subdirectory( doc )|' ${CACHE_PATH}/${pkg_name}/CMakeLists.txt
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
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
