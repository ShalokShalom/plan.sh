pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kde-gtk-config
pkg_version=${_plasmaver}
pkg_description="Configuration dialog to adapt GTK applications appearance to your taste under KDE"
pkg_upstream_url="https://projects.kde.org/projects/kde/workspace/kde-gtk-config"
pkg_license=('LGPL')
pkg_deps=('karchive' 'kauth' 'kcmutils' 'kconfigwidgets' 'knewstuff')
pkg_build_deps=('extra-cmake-modules' 'git' 'gtk2' 'gtk3')
#pkg_source=("http://download.kde.org/stable/plasma/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_source=("${pkg_name}-${pkg_version}.tar.gz::https://github.com/KDE/${pkg_name}/archive/${_branch}.tar.gz")
pkg_shasum=(`grep ${pkg_name}-${_plasmaver}.tar.gz ../kf5.md5 | cut -d" " -f1`)

do_build() {
  cd $pkg_name-${__pkg_version}
  mkdir build
  
  cd build
  cmake -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_BUILD_TYPE=Release \
        -DLIB_INSTALL_DIR=lib \
        -DLIBEXEC_INSTALL_DIR=lib \
        -DSYSCONF_INSTALL_DIR=/etc \
        -DQML_INSTALL_DIR=/usr/lib/qt5/qml \
        -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
        -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
        -DBUILD_TESTING=OFF ..
  make
}

do_package() {
  cd $pkg_name-${__pkg_version}/build
  
  make DESTDIR=${pkg_prefix} install
}
