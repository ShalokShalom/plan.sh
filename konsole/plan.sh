pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=konsole
pkg_version=${_kdever}
pkg_description="KDE's terminal emulator"
pkg_upstream_url='https://github.com/KDE/konsole'
pkg_license=('LGPL')
pkg_deps=('kbookmarks' 'kcompletion' 'kconfig' 'kconfigwidgets' 'kcoreaddons'
         'kguiaddons' 'kdbusaddons' 'ki18n' 'kiconthemes' 'kinit' 'kio'
         'knotifications' 'knotifyconfig' 'kparts' 'kpty' 'kservice' 
         'ktextwidgets' 'kwidgetsaddons' 'kwindowsystem' 'kxmlgui')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("$_mirror/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  # fix transparency
  #patch -p1 -i ${CACHE_PATH}/fca305ebffd331701b59e68ab446db9618987b6f.diff
}
         
do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_LIBDIR=lib
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}

