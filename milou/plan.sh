pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=milou
pkg_version=${_plasmaver}
pkg_description="Dedicated search application built on top of Baloo"
pkg_upstream_url='https://projects.kde.org/projects/kdereview/milou'
pkg_license=('GPL')
pkg_deps=('krunner' 'plasma-framework' 'ki18n' 'kdeclarative')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
#pkg_source=("http://download.kde.org/stable/plasma/$pkg_version/${pkg_name}-$pkg_version.tar.xz")
pkg_source=("${pkg_name}-${pkg_version}.tar.gz::https://github.com/KDE/${pkg_name}/archive/${_branch}.tar.gz")
pkg_shasum=(`grep ${pkg_name}-${_plasmaver}.tar.gz ../kf5.md5 | cut -d" " -f1`)

do_build() {
  mkdir -p build
  cd build

  cmake ../${pkg_name}-${__pkg_version} \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=/usr \
      -DQML_INSTALL_DIR=/usr/lib/qt5/qml \
      -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
      -DLIB_INSTALL_DIR=lib
  make
}

do_package() {
  cd build

  make DESTDIR="${pkg_prefix}" install
}
