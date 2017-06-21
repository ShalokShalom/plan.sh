pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kmix
pkg_version=${_kdever}
pkg_description="KDE volume control program"
pkg_upstream_url='http://kde.org/applications/multimedia/kmix/'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kxmlgui' 'ki18n' 'kdelibs4support' 'kdbusaddons' 'kglobalaccel' 'kconfigwidgets' 'kiconthemes'
         'libcanberra-pulse' 'pulseaudio' 'alsa-lib' 'phonon-qt5' 'plasma-framework') # 'solid'
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'pkg-config')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
#pkg_source=("git://anongit.kde.org/kmix.git")
#pkg_shasum=('SKIP')

do_prepare() {
  cd $pkg_name-${pkg_version}
  #sed -i -e 's/KF5 REQUIRED COMPONENTS I18n Init Config Solid KDELibs4Support/KF5 REQUIRED COMPONENTS I18n Init Config Solid KDELibs4Support DBusAddons/' ${CACHE_PATH}/${pkg_name}/CMakeLists.txt
  #sed -i -e 's/KF5::KDELibs4Support/KF5::KDELibs4Support KF5::DBusAddons K5::GLobalAccel/' ${CACHE_PATH}/${pkg_name}/CMakeLists.txt
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
    -DSYSCONF_INSTALL_DIR=/etc \
    -DBUILD_TESTING=OFF \
    -DKMIX_KF5_BUILD=1
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
