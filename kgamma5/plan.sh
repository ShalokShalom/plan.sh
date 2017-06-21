pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kgamma5
_pkg_name=kgamma
pkg_version=${_plasmaver}
#pkg_version=15.03.71
pkg_description="Adjust your monitor's gamma settings"
pkg_upstream_url='https://projects.kde.org/projects/kde/kdegraphics/kgamma'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kdelibs4support' 'libxxf86vm')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'git')
#pkg_source=("$_mirror/${pkg_name}-$_plasmaver.tar.xz")
pkg_source=("${pkg_name}-${pkg_version}.tar.gz::https://github.com/KDE/${pkg_name}/archive/${_branch}.tar.gz")
pkg_shasum=(`grep ${pkg_name}-${_plasmaver}.tar.gz ../kf5.md5 | cut -d" " -f1`)

do_build() {
  mkdir -p build
  cd build

  cmake ../${pkg_name}-${__pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DSYSCONF_INSTALL_DIR=/etc \
    -DQML_INSTALL_DIR=/usr/lib/qt5/qml \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
