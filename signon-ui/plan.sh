pkg_origin=

pkg_name=signon-ui
pkg_version=0.17.2
_pkg_version=0.17+15.10.20150810
pkg_description='UI component responsible for handling the user interactions which can happen during the login process of an online account'
pkg_upstream_url="https://gitlab.com/accounts-sso/signon-ui"
pkg_license=('GPL')
pkg_deps=('accountsqt' 'qtwebkit-tp' 'signonqt' 'libnotify')
pkg_source=("http://archive.ubuntu.com/ubuntu/pool/main/s/signon-ui/${pkg_name}_${_pkg_version}.orig.tar.gz")
pkg_shasum=('560ea77014d0418c4899984486839da8')

do_build() {
  cd ${pkg_name}-${_pkg_version}

  /usr/lib/qt5/bin/qmake PREFIX=/usr LIBDIR=/usr/lib
  make
}

do_package() {
  cd ${pkg_name}-${_pkg_version}

  make INSTALL_ROOT=${pkg_prefix} install
}
