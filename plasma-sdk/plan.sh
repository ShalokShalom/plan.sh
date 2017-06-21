pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=plasma-sdk
pkg_version=${_plasmaver}
pkg_description="Applications useful for Plasma Development."
pkg_upstream_url="https://projects.kde.org/projects/extragear/sdk/plasma-sdk"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('karchive' 'kcompletion' 'kconfig' 'kconfigwidgets' 'kcoreaddons' 'kdbusaddons'
         'kdeclarative' 'ki18n' 'kiconthemes' 'kitemmodels' 'kio' 'knewstuff' 'kparts' 
         'plasma-framework' 'kservice' 'ktexteditor' 'kwidgetsaddons' 'kxmlgui' 'kwindowsystem'
         'kirigami' 'kdelibs4support' 'kdevplatform' 'qt5-webkit')
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
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
