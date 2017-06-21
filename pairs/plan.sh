pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=pairs
#pkg_version=${_kdever}
pkg_version=15.11.70
pkg_description="A memory and pairs game for KDE"
pkg_upstream_url="https://projects.kde.org/projects/kde/kdeedu/pairs"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('karchive' 'kcompletion' 'kcoreaddons' 'kio' 'knewstuff' 'kdelibs4support' 'kdeclarative'
         'knotifications' 'kxmlgui' 'kdeedu-data' 'phonon-qt5')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'git')
#groups=('kde' 'kdeedu' 'kde-uninstall' 'education' 'kaos-kids')
#pkg_source=("$_mirror/${_pkg_name}-$_kdever.tar.xz")
#pkg_shasum=(`grep ${_pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
pkg_source=("git://anongit.kde.org/pairs.git#branch=frameworks")
pkg_shasum=('SKIP')

do_prepare() {
  cd $pkg_name
  #sed -i -e 's|add_subdirectory( doc )|#add_subdirectory( doc )|' ${CACHE_PATH}/${pkg_name}/CMakeLists.txt
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name} \
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

