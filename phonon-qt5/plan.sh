pkg_origin=cosmos

pkg_name=phonon-qt5
_pkg_name=phonon
pkg_version=4.9.1
pkg_upstream_url="https://phonon.kde.org"
pkg_license=('LGPL')
pkg_description="The multimedia framework for KDE"
pkg_deps=('phonon-backend-qt5' 'pulseaudio' 'qt5-base')
pkg_build_deps=('extra-cmake-modules' 'qt5-tools')
pkg_source=("http://download.kde.org/stable/phonon/${pkg_version}/${_pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('7896a560f5da345a626e782610c8e71e')

do_build() {
  mkdir -p build
  
  cmake ../${_pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_SKIP_RPATH=ON \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DPHONON_BUILD_PHONON4QT5=ON \
    -DPHONON_INSTALL_QT_EXTENSIONS_INTO_SYSTEM_QT=ON 
  make
}

do_package(){
  
  make DESTDIR=${pkg_prefix} install
}
