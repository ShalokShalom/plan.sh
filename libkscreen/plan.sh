pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=libkscreen
pkg_version=${_plasmaver}
pkg_description="A library for extracting file metadata"
pkg_upstream_url='https://projects.kde.org/projects/kde/workspace/libkscreen'
pkg_license=('LGPL')
pkg_deps=('qt5-x11extras' 'kwayland')
pkg_build_deps=('extra-cmake-modules')
pkg_source=("http://download.kde.org/unstable/plasma/$pkg_version/${pkg_name}-${pkg_version}.tar.xz")
#pkg_source=("${pkg_name}-${pkg_version}.tar.gz::https://github.com/KDE/${pkg_name}/archive/${_branch}.tar.gz")
pkg_shasum=(`grep ${pkg_name}-${_plasmaver}.tar.xz ../kf5.md5 | cut -d" " -f1`)

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DECM_MKSPECS_INSTALL_DIR=/usr/lib/qt5/mkspecs/modules \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_LIBEXECDIR=lib
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
