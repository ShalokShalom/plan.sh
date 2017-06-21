pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=wacomtablet
pkg_version=2.9.80
_pkg_version=3.0.0~beta1
pkg_description="Implements a GUI for the Wacom Linux Drivers and extends it with profile support to handle 
         different button / pen layouts per profile."
pkg_upstream_url='https://github.com/KDE/wacomtablet'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kcoreaddons' 'ki18n' 'kglobalaccel' 'kconfig' 'kxmlgui' 'kwidgetsaddons' 'kwindowsystem' 'knotifications'
         'kdbusaddons' 'plasma-framework' 'xf86-input-wacom')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("https://dl.opendesktop.org/api/files/download/id/1466630714/114856-wacomtablet-${_pkg_version}.tar.xz")
pkg_shasum=('95d1d29063d6de2ab0881c33e8eacb05')

do_prepare() {
   cd ${pkg_name}-${_pkg_version}
   #patch -p1 -i ${CACHE_PATH}/CMakeLists.diff
   sed -i -e 's|MacroOptionalAddSubdirectory|ECMOptionalAddSubdirectory|' CMakeLists.txt
   sed -i -e 's|macro_optional_add_subdirectory|ecm_optional_add_subdirectory|' CMakeLists.txt
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${_pkg_version} \
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
