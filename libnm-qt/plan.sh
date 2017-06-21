pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=libnm-qt
pkg_version=${_plasmaver}
pkg_description='Qt-only wrapper for NetworkManager DBus API'
pkg_upstream_url='https://projects.kde.org/projects/extragear/libs/libnm-qt'
pkg_license=('LGPL')
pkg_deps=('qt5-base' 'networkmanager')
pkg_build_deps=('extra-cmake-modules')
pkg_source=("http://download.kde.org/stable/plasma/$pkg_version/$pkg_name-$pkg_version.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_plasmaver.tar.xz ../kf5.md5 | cut -d" " -f1`)
#pkg_source=("git://anongit.kde.org/libnm-qt.git")
#pkg_shasum=('SKIP')

do_build() {
  cd $pkg_name-$pkg_version
  mkdir build
  
  cd build
  cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DINCLUDE_INSTALL_DIR=/usr/include/KF5
  make
}

do_package() {
  cd $pkg_name-$pkg_version/build
  
  make DESTDIR=${pkg_prefix} install
}
