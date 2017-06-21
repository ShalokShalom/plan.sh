pkg_origin=cosmos

pkg_name=signonqt
pkg_version=8.59
_pkg_version=VERSION_8.58-aa1bcf3c9218addbdb376a40151b689409046125
pkg_upstream_url="https://gitlab.com/accounts-sso/signond/"
pkg_license=('LGPL')
pkg_description="Framework to provide credential storage and authentication service, Qt5 version"
pkg_deps=('qt5-base' 'libproxy')
pkg_build_deps=('doxygen' 'ttf-dejavu' 'qt5-tools')
backup=('etc/signond.conf')
pkg_source=("https://gitlab.com/accounts-sso/signond/repository/archive.tar.bz2?ref=VERSION_${pkg_version}")
pkg_shasum=('e08708ad4ca14554c361b1cd270c977a')

do_build() {
  #sed -i 's/qdbusxml2cpp/qdbusxml2cpp-qt5/' src/signond/signond.pro
  
  /usr/lib/qt5/bin/qmake CONFIG+=coverage PREFIX=/usr LIBDIR=/usr/lib
  make
}

do_package() { 
  
  make INSTALL_ROOT=${CACHE_PATH} install
}

