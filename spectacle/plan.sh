pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=spectacle
pkg_version=${_kdever}
_commit=1836e435a0c0ac822088ef35875f9caaae9ccd03
pkg_description="The new KDE Screenshot Utility"
pkg_upstream_url="https://github.com/KDE/spectacle"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kcoreaddons' 'kwidgetsaddons' 'kdbusaddons' 'knotifications' 'kconfig' 'ki18n' 'kio' 'kxmlgui'
         'kwindowsystem' 'kdeclarative' 'libkipi' 'libkscreen' 'xcb-util-cursor') # needed in 15.12? 'purpose') 
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'pkg-config')
pkg_source=("$_mirror/${pkg_name}-${_kdever}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
#pkg_source=("https://github.com/KDE/spectacle/archive/${_commit}.zip")
#pkg_shasum=('ea83d503005de394dec07d6fc1039712')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build
  make DESTDIR=${pkg_prefix} install
  
  # remove icons for now, they are from ksnaphot
  #rm -r ${pkg_prefix}/usr/share/icons/hicolor/*/apps/ksnapshot.png
}
