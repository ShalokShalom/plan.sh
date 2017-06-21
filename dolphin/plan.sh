pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=dolphin
pkg_version=${_kdever}
pkg_description="KDE File Manager"
pkg_upstream_url='https://projects.kde.org/projects/kde/applications/dolphin'
pkg_license=('LGPL')
pkg_deps=('kinit' 'kcmutils' 'knewstuff' 'kcoreaddons' 'ki18n' 'kdbusaddons' 'kbookmarks' 'kconfig' 'kio' 'kparts' 'solid'
         'kiconthemes' 'kcompletion' 'ktextwidgets' 'kwindowsystem' 'knotifications' 'baloo-widgets' 'kactivities' 
         'kfilemetadata') 
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz"
        "https://github.com/KDE/dolphin/commit/0bdd8e0b0516555c6233fdc7901e9b417cf89791.diff")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`
         '213f3dbcdd374f1f74a87a08d28de0fd')

do_prepare() {
  cd $pkg_name-${pkg_version}
  # keep kdesu option for dolphin, comment out for now, wait for upstream decision
  patch -R -p1 -i ${CACHE_PATH}/0bdd8e0b0516555c6233fdc7901e9b417cf89791.diff
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DKDE_INSTALL_LIBDIR=lib
  make
}

do_package() {
  cd build

  make DESTDIR="${pkg_prefix}" install
}
