pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=akonadi
pkg_version=${_kdever}
pkg_upstream_url='https://community.kde.org/KDE_PIM/Akonadi'
pkg_description="PIM layer, which provides an asynchronous API to access all kind of PIM data"
pkg_license=('LGPL')
pkg_deps=('shared-mime-info' 'mariadb' 'qt5-base' 'libxslt' 'kitemviews'  'kio' 'kconfig' 'ki18n'
         'kdesignerplugin' 'kdbusaddons' 'kitemmodels' 'kguiaddons' 'kiconthemes' 'kwindowsystem'
         'kcompletion')
pkg_build_deps=('extra-cmake-modules' 'postgresql' 'boost' 'qt5-tools')
optpkg_deps=('postgresql: PostgreSQL backend')
pkg_source=("$_mirror/${pkg_name}-${_kdever}.tar.xz"
        "https://github.com/KDE/akonadi/commit/2dc7fbf569ba3f7eeef98fb818d7af0820caf7a3.diff") 
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`
         '65deb2ccabfb088e8e94daffb9b511a3')

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  # https://bugs.kde.org/show_bug.cgi?id=380182
  patch -p1 -i ${CACHE_PATH}/2dc7fbf569ba3f7eeef98fb818d7af0820caf7a3.diff
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
