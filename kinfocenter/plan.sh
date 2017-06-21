pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kinfocenter
pkg_version=${_plasmaver}
pkg_description='KInfocenter'
pkg_upstream_url='https://github.com/KDE/kinfocenter'
pkg_license=('LGPL')
pkg_deps=('glu' 'kcmutils' 'kdelibs4support' 'kemoticons' 'libraw1394' 'pciutils' 'plasma-framework' 'kwayland')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("http://download.kde.org/unstable/plasma/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz"
#pkg_source=("${pkg_name}-${pkg_version}.tar.gz::https://github.com/KDE/${pkg_name}/archive/${_branch}.tar.gz"
        'kcm-about-distrorc'
        'KaOS.png')
pkg_shasum=(`grep ${pkg_name}-${_plasmaver}.tar.xz ../kf5.md5 | cut -d" " -f1`
         'df8749d99a71076017cb1e17cd610038'
         '0957d15eee83c30c1351571d3b875bc9')


do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build
  make DESTDIR=${pkg_prefix} install
  
  install -Dm644 ${CACHE_PATH}/kcm-about-distrorc ${pkg_prefix}/etc/xdg/kcm-about-distrorc
  install -Dm644 ${CACHE_PATH}/KaOS.png ${pkg_prefix}/usr/share/${pkg_name}/KaOS.png
  
  rm -r ${pkg_prefix}/usr/share/locale
}

