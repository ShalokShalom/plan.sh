pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=bluedevil
pkg_version=${_plasmaver}
pkg_description='KDE bluetooth framework'
pkg_upstream_url="https://projects.kde.org/projects/extragear/base/bluedevil"
pkg_license=('GPL')
pkg_deps=('bluez-qt' 'bluez' 'kcoreaddons' 'kwidgetsaddons' 'kdbusaddons' 'ki18n' 'kinit' 'kio'
         'kiconthemes' 'knotifications' 'plasma-framework' 'kded')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
#pkg_source=("http://download.kde.org/stable/plasma/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_source=("${pkg_name}-${pkg_version}.tar.gz::https://github.com/KDE/${pkg_name}/archive/${_branch}.tar.gz")
pkg_shasum=(`grep ${pkg_name}-${_plasmaver}.tar.gz ../kf5.md5 | cut -d" " -f1`)

do_prepare() {
  cd ${CACHE_PATH}/${pkg_name}-${__pkg_version}
  
  #patch -p1 -i $CACHE_PATH/bluezqt5.11.patch
}
         
do_build() {
  cd ${CACHE_PATH}
  
  mkdir build
  
  cd build
  cmake ../${pkg_name}-${__pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DLIBEXEC_INSTALL_DIR=lib \
    -DSYSCONF_INSTALL_DIR=/etc \
    -DQML_INSTALL_DIR=/usr/lib/qt5/qml \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd ${CACHE_PATH}/build
  
  make DESTDIR=${pkg_prefix} install
}
