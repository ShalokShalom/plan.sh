pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=ktexteditor
pkg_version=${_kf5ver}
pkg_description='KTextEditor provides a powerful text editor component that you can embed in your application'
pkg_upstream_url='https://github.com/KDE/ktexteditor'
pkg_license=('LGPL')
pkg_deps=('karchive' 'kconfig' 'kguiaddons' 'ki18n' 'kio' 'kparts' 'sonnet' 'kiconthemes' 'syntax-highlighting')
pkg_build_deps=('extra-cmake-modules')
pkg_source=("http://download.kde.org/stable/frameworks/5.12/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kf5ver.tar.xz ../kf5.md5 | cut -d" " -f1`)

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