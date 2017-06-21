pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=krfb
pkg_version=${_kdever}
#pkg_version=15.11.74
pkg_description='Desktop Sharing Server'
pkg_upstream_url='http://www.kde.org/applications/system/krfb'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('ki18n' 'kcompletion' 'kconfig' 'kcrash' 'kcoreaddons' 'kdnssd' 'knotifications' 'kwallet' 'kwidgetsaddons'
         'kdbusaddons' 'kxmlgui' 'libvncserver' 'libxdamage' 'ktp-common-internals')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
#pkg_source=("git://anongit.kde.org/krfb.git")
#pkg_shasum=('SKIP')

do_build() {
  mkdir build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build
  
  make DESTDIR=$pkg_prefix install
}
