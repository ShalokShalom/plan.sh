pkg_origin=

pkg_name=polkit-qt5
_pkg_name=polkit-qt-1
pkg_version=0.112.0.1
pkg_description='Qt5 wrapper around polkit-1 client libraries, to provide the polkit-1 kauth used by KDE'
pkg_upstream_url='https://projects.kde.org/projects/kdesupport/polkit-qt-1'
pkg_license=('LGPL')
pkg_deps=('polkit' 'qt5-base')
pkg_build_deps=('extra-cmake-modules')
pkg_source=('git://anongit.kde.org/polkit-qt-1')
#pkg_source=("http://download.kde.org/stable/apps/KDE4.x/admin/${_pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('SKIP')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${_pkg_name} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_INSTALL_LIBDIR=lib
  make
}

do_package() {
  cd build
  
  make DESTDIR="${pkg_prefix}" install
}
