pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=filelight
pkg_version=${_kdever}
pkg_description="Allows you to understand exactly where your diskspace is being used bygraphically representating your filesystem"
pkg_upstream_url="https://projects.kde.org/projects/kde/kdeutils/filelight"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kio' 'kparts' 'kxmlgui' 'kcoreaddons' 'solid')
pkg_build_deps=('pkg-config' 'extra-cmake-modules' 'kdoctools')
pkg_source=($_mirror/${pkg_name}-$_kdever.tar.xz)
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_build() {
  mkdir build
  
  cd build
  cmake ../${pkg_name}-${pkg_version} \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_BUILD_TYPE=Release \
        -DLIB_INSTALL_DIR=lib \
        -DSYSCONF_INSTALL_DIR=/etc \
        -DQML_INSTALL_DIR=/usr/lib/qt5/qml \
        -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
        -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build
  
  make DESTDIR=$pkg_prefix install
}
