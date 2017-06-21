pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=signon-kwallet-extension
pkg_version=${_kdever}
pkg_description="KWallet integration for signon framework (code.google.com/p/accounts-sso)"
pkg_upstream_url="https://projects.kde.org/projects/kdereview/signon-kwallet-extension"
pkg_license=('LGPL')
pkg_deps=('signon-qt5' 'kwallet')
pkg_build_deps=('extra-cmake-modules' 'git')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_build() {
  mkdir -p build

  cd build
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build

  make DESTDIR="${pkg_prefix}" install
}
