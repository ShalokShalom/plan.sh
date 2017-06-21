pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=breeze
pkg_version=${_plasmaver}
pkg_description='Artwork, styles and assets for the Breeze visual style for the Plasma Desktop'
pkg_upstream_url='https://projects.kde.org/projects/kde/workspace/breeze'
pkg_license=('LGPL')
pkg_deps=('kdecoration' 'kpackage' 'ki18n' 'frameworkintegration' 'breeze-icons' 'kwayland'
         'kcmutils')
pkg_build_deps=('extra-cmake-modules')
#pkg_source=("http://download.kde.org/stable/plasma/$pkg_version/$pkg_name-$pkg_version.tar.xz")
pkg_source=("${pkg_name}-${pkg_version}.tar.gz::https://github.com/KDE/${pkg_name}/archive/${_branch}.tar.gz")
pkg_shasum=(`grep ${pkg_name}-$_plasmaver.tar.gz ../kf5.md5 | cut -d" " -f1`)

prepare () {
  cd $pkg_name-${__pkg_version}
  #sed -i -e 's|devices emblems places status|devices emblems emotes mimetypes places status|' icons-dark/CMakeLists.txt

  #patch -p1 -i $CACHE_PATH/c2008d6d3a62b3f7f6e5198e047d39b4a40ecf7e.diff
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
    -DBUILD_TESTING=OFF
  make
}

package () {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}

