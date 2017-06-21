pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=koko
#pkg_version=${_kdever}
pkg_version=0.1.0
pkg_description="An Image Gallery application"
pkg_upstream_url='https://projects.kde.org/projects/playground/graphics/koko'
pkg_license=('LGPL')
pkg_deps=('baloo' 'plasma-framework' 'ki18n' 'kdeclarative' 'kconfig' 'kdbusaddons' 'exiv2')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'git')
pkg_source=("git://anongit.kde.org/koko.git")
pkg_shasum=('SKIP')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DSYSCONF_INSTALL_DIR=/etc \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DLIB_INSTALL_DIR=lib 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
