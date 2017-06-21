pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=ktp-accounts-kcm
pkg_version=${_kdever}
pkg_description="KCM Module for configuring Telepathy Instant Messaging Accounts"
pkg_upstream_url="https://projects.kde.org/projects/extragear/network/telepathy/ktp-accounts-kcm"
pkg_license=('GPL')
pkg_deps=('kcmutils' 'kio' 'ki18n' 'kwidgetsaddons' 'kcoreaddons' 'kconfigwidgets' 'kiconthemes'
         'kitemviews' 'ktp-common-internals' 'telepathy-gabble' 'kaccounts-providers')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'git' 'boost' 'intltool')
optpkg_deps=('telepathy-haze: all protocols supported by libpurple')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  sed -i -e 's|add_subdirectory (sipe)|#add_subdirectory (sipe)|' plugins/CMakeLists.txt
}

do_build() {
  mkdir -p build
  cd build

  cmake ../${pkg_name}-${pkg_version} \
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
  # remove sipe protocol from accounts view
  rm ${pkg_prefix}/usr/share/accounts/providers/kde/ktp-sipe.provider
  rm ${pkg_prefix}/usr/share/accounts/providers/kde/ktp-sipe-haze.provider
}
