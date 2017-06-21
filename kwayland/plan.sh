pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kwayland
pkg_version=${_kf5ver}
pkg_description="KWayland provides a Qt-style Client and Server library wrapper for the Wayland libraries"
pkg_upstream_url="https://github.com/KDE/kwayland"
pkg_license=('LGPLv2+')
pkg_deps=('qt5-base' 'wayland')
pkg_build_deps=('extra-cmake-modules' 'git')
#pkg_source=("git://anongit.kde.org/kwayland.git")
pkg_source=("http://download.kde.org/stable/frameworks/5.23/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kf5ver.tar.xz ../kf5.md5 | cut -d" " -f1`)

do_build() {
  mkdir -p build
  
  cd build
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_LIBEXECDIR=lib
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
