pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kwayland-integration
pkg_version=${_plasmaver}
pkg_description="Provides integration plugins for various KDE frameworks for the wayland windowing system."
pkg_upstream_url="https://projects.kde.org/projects/kde/workspace/kwayland-integration"
pkg_license=('LGPLv2+')
pkg_deps=('kidletime' 'kwindowsystem' 'kwayland')
pkg_build_deps=('extra-cmake-modules'  'kdoctools')
#pkg_source=("http://download.kde.org/stable/plasma/$pkg_version/${pkg_name}-$pkg_version.tar.xz")
pkg_source=("${pkg_name}-${pkg_version}.tar.gz::https://github.com/KDE/${pkg_name}/archive/${_branch}.tar.gz")
pkg_shasum=(`grep ${pkg_name}-${_plasmaver}.tar.gz ../kf5.md5 | cut -d" " -f1`)

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${__pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DLIB_INSTALL_DIR=lib
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
