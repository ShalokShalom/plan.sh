pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=dragon
pkg_version=${_kdever}
pkg_description="A multimedia player where the focus is on simplicity, instead of features"
pkg_upstream_url='http://kde.org/applications/multimedia/dragonplayer/'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kconfig' 'kconfigwidgets' 'kcoreaddons' 'ki18n' 'kio' 'knotifications'
         'kwidgetsaddons' 'kwindowsystem' 'kparts' 'solid' 'kxmlgui' 'kjobwidgets' 
         'kdbusaddons' 'phonon-qt5')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("$_mirror/${pkg_name}-${_kdever}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  #sed -i -e 's|V4.2-Based Variant V1.1//EN" "dtd/kdex.dtd"|V4.5-Based Variant V1.1//EN" "dtd/kdedbx45.dtd"|' ${CACHE_PATH}/${pkg_name}/doc/index.docbook
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}

