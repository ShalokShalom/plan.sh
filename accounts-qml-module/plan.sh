pkg_origin=

pkg_name=accounts-qml-module
pkg_version=0.7
pkg_description='Client library for using Online Accounts from QML applications.'
pkg_upstream_url="https://gitlab.com/accounts-sso/accounts-qml-module"
pkg_license=('LGPL')
pkg_deps=('accountsqt' 'signonqt' 'qt5-declarative')
pkg_build_deps=('qt5-tools')
pkg_source=("https://gitlab.com/accounts-sso/accounts-qml-module/repository/archive.tar.bz2?ref=VERSION_${pkg_version}")
pkg_shasum=('633ae6f6c84f073d1e1bb978086e7dfd')

do_build() {
  cd accounts-qml-module-VERSION_${pkg_version}-*

  /usr/lib/qt5/bin/qmake PREFIX=/usr LIBDIR=/usr/lib
  make
}

do_package() {
  cd accounts-qml-module-VERSION_${pkg_version}-*
  make INSTALL_ROOT=$pkg_prefix install
  
  rm -r $pkg_prefix/usr/share
}
