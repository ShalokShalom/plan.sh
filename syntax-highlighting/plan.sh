pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=syntax-highlighting
pkg_version=${_kf5ver}
pkg_description='Syntax highlighting Engine for Structured Text and Code.'
pkg_upstream_url='https://github.com/KDE/syntax-highlighting'
pkg_license=('LGPL')
pkg_deps=('qt5-xmlpatterns' 'perl')
pkg_build_deps=('extra-cmake-modules' 'qt5-tools')
pkg_source=("http://download.kde.org/stable/frameworks/5.28/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kf5ver.tar.xz ../kf5.md5 | cut -d" " -f1`)

prepare () {
  cd ${pkg_name}-${pkg_version}
  # syntax highlighting for PKGBUILD files
  sed -i -e 's|.bash_login;.profile|.bash_login;.profile;PKGBUILD|' data/syntax/bash.xml
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
