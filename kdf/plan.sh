pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf
    
pkg_name=kdf
pkg_version=${_kdever}
#pkg_version=16.07.71
pkg_description="Displays the available file devices along with information on their capacity, free space, type and mount point."
pkg_upstream_url="https://www.kde.org/applications/system/kdiskfree/"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kconfigwidgets' 'kcoreaddons' 'ki18n' 'kiconthemes' 'kio' 'kcmutils' 'knotifications'
         'kwidgetsaddons' 'kxmlgui')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=($_mirror/${pkg_name}-${_kdever}.tar.xz)
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  #sed -i -e 's|V4.2-Based Variant V1.1//EN" "dtd/kdex.dtd"|V4.5-Based Variant V1.1//EN" "dtd/kdedbx45.dtd"|' doc/app/index.docbook
  #sed -i -e 's|V4.2-Based Variant|V4.5-Based Variant|' doc/kcontrol/index.docbook
  #sed -i -e 's|dtd/kdex.dtd|dtd/kdedbx45.dtd|' doc/kcontrol/index.docbook
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DSYSCONF_INSTALL_DIR=/etc \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DLIB_INSTALL_DIR=lib
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
