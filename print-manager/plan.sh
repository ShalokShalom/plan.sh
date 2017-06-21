pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=print-manager
pkg_version=${_kdever}
pkg_description="A KDE tool for managing print jobs and printers"
pkg_upstream_url="https://projects.kde.org/projects/kde/kdeutils/print-manager"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kconfig' 'kconfigwidgets' 'kcoreaddons' 'kdbusaddons' 'kiconthemes'
         'ki18n' 'kcmutils' 'kio' 'knotifications' 'plasma-framework'
         'kwidgetsaddons' 'kwindowsystem' 'libcups' 'qt5-tools')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz"
        's-c-p.diff')
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`
         'e7da0b573925cc79b097926748a04973')

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  
  patch -p1 -i ${CACHE_PATH}/s-c-p.diff
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version}  \
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
}
