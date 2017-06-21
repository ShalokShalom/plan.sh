pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=plasma-integration
pkg_version=${_plasmaver}
pkg_description='The plugin KDEPlatformTheme provides KDE integration for QPlatformThemePlugin.'
pkg_upstream_url='https://github.com/KDE/plasma-integration'
pkg_license=('LGPL')
pkg_deps=('kconfig' 'kconfigwidgets' 'ki18n' 'kiconthemes' 'kio' 'knotifications' 'kwidgetsaddons'
         'kwayland' 'noto-fonts' 'breeze' 'ttf-hack')
pkg_build_deps=('extra-cmake-modules')
#pkg_source=("http://download.kde.org/stable/plasma/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz"
pkg_source=("${pkg_name}-${pkg_version}.tar.gz::https://github.com/KDE/${pkg_name}/archive/${_branch}.tar.gz"
        'fix_switched_open_save.patch')
pkg_shasum=(`grep ${pkg_name}-${_plasmaver}.tar.gz ../kf5.md5 | cut -d" " -f1`
         '07517f31cddac433f5bfdbaff7eb506f')

prepare () {
  cd ${pkg_name}-${__pkg_version}
  #patch -p1 -i ${CACHE_PATH}/fix_switched_open_save.patch
}
  
build () {  
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${__pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF \
    -DCMAKE_DISABLE_FIND_PACKAGE_FontNotoSans=false \
    -DCMAKE_DISABLE_FIND_PACKAGE_FontHack=false
  make
}

package () {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}

