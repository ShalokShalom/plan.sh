pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=plasma-desktop
pkg_version=${_plasmaver}
pkg_description='KDE Plasma Desktop'
pkg_upstream_url='https://github.com/KDE/plasma-desktop'
pkg_license=('LGPL')
pkg_deps=('qt5-graphicaleffects' 'libxkbfile' 'libusb' 'libcanberra' 'polkit-kde-agent-1'
         'systemsettings' 'ksysguard' 'powerdevil' 'kmenuedit' 'kpeople' 
         'kdbusaddons' 'plasma-integration' 'xf86-input-synaptics' 'xorg-server' 'kactivities-stats')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'boost')
#pkg_source=("http://download.kde.org/stable/plasma/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_source=("${pkg_name}-${pkg_version}.tar.gz::https://github.com/KDE/${pkg_name}/archive/${_branch}.tar.gz"
        'layout_desktop_panel.diff'
        'main_desktop_kicker.diff')
pkg_shasum=(`grep ${pkg_name}-${_plasmaver}.tar.gz ../kf5.md5 | cut -d" " -f1`
         '5a22b33c2f9ed93c8b8f580601e00a8e'
         '22b66401945f92bd9f99e6d334bc306e')

do_prepare() {
  cd ${pkg_name}-${__pkg_version}
  # prep for plasma 5.5, move to noto, no longer use oxygen-fonts in KaOS, uncomment with 5.5
  sed -i -e 's|QFont f1("Oxygen Mono", 9); // fixed font|QFont f1("DejaVu Sans Mono", 9); // fixed font|' kcms/fonts/fonts.cpp
  # adjust default settings for panel, kicker & desktop view
  patch -p1 -i ${CACHE_PATH}/layout_desktop_panel.diff
  patch -p1 -i ${CACHE_PATH}/main_desktop_kicker.diff
  sed -i 's|org.kde.plasma.folder|org.kde.desktopcontainment|' desktoppackage/contents/defaults
}

do_build() {
  mkdir -p build
  
  cd build
  cmake ../${pkg_name}-${__pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_LIBEXECDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
