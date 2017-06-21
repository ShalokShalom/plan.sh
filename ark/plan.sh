pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=ark
pkg_version=${_kdever}
pkg_description="Archiver for various compression formats"
pkg_upstream_url="https://github.com/KDE/ark"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('karchive' 'kconfig' 'kpty' 'khtml' 'kdbusaddons' 'ki18n' 'kiconthemes'
         'kio' 'kservice' 'kwidgetsaddons' 'kitemmodels'
         'libarchive' 'p7zip' 'zip' 'unzip' 'unrar' 'libzip')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=($_mirror/${pkg_name}-$_kdever.tar.xz)
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_prepare() {
  cd ${pkg_name}-${pkg_version}
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
