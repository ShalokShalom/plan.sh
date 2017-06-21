pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=discover
pkg_version=${_plasmaver}
pkg_description="An Application Installer for the 22nd Century"
pkg_upstream_url="https://userbase.kde.org/Discover"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kcoreaddons' 'kconfig' 'kcrash' 'kdbusaddons' 'ki18n' 'karchive' 'kcompletion' 
         'kdeclarative' 'kxmlgui' 'kitemmodels' 'kio' 'knewstuff' 'kf5-attica' 
         'knotifications' 'kirigami' 'appstream' 'flatpak')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
#pkg_source=($_mirror/${pkg_name}-$_plasmaver.tar.xz)
pkg_source=("${pkg_name}-${pkg_version}.tar.gz::https://github.com/KDE/${pkg_name}/archive/${_branch}.tar.gz")
pkg_shasum=(`grep ${pkg_name}-${_plasmaver}.tar.gz ../kf5.md5 | cut -d" " -f1`)

do_build() {
  mkdir -p build
  cd build

  cmake ../${pkg_name}-${__pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_LIBEXECDIR=lib \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
