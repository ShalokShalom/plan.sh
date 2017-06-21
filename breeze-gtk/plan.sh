pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=breeze-gtk
pkg_version=${_plasmaver}
pkg_description='Widget theme for GTK 2 and 3'
pkg_upstream_url='https://github.com/KDE/breeze-gtk'
pkg_license=('LGPL')
pkg_deps=('qt5-base' 'kcoreaddons' 'kconfig')
pkg_build_deps=('extra-cmake-modules' 'gtk2' 'gtk3')
oppkg_deps=("gtk2: GTK+2 theme" "gtk3: GTK+3 theme")
#pkg_source=("http://download.kde.org/stable/plasma/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_source=("${pkg_name}-${pkg_version}.tar.gz::https://github.com/KDE/${pkg_name}/archive/${_branch}.tar.gz")
pkg_shasum=(`grep ${pkg_name}-${_plasmaver}.tar.gz ../kf5.md5 | cut -d" " -f1`)

prepare () {
  cd ${pkg_name}-${__pkg_version}
  #sed -i -e 's|devices emblems places status|devices emblems emotes mimetypes places status|' icons-dark/CMakeLists.txt

  #patch -p1 -i $CACHE_PATH/1a547a83dc1bb1c4a0e6d61df747b0426c53531a.diff
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
    -DWITH_GTK3_VERSION=3.20 
  make
}

package () {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}

