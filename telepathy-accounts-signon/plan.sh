pkg_origin=

pkg_name=telepathy-accounts-signon
pkg_version=1.0
pkg_description='Mission control plugin for Telepathy, integrating with libaccounts and libsignon to provide IM accounts and authentication.'
pkg_upstream_url="https://gitlab.com/accounts-sso/telepathy-accounts-signon"
pkg_license=('LGPL')
pkg_deps=('qt5-base' 'telepathy-mission-control' 'libaccounts-glib' 'libsignon-glib')
# https://gitlab.com/accounts-sso/telepathy-accounts-signon/tags
pkg_source=("https://gitlab.com/accounts-sso/telepathy-accounts-signon/repository/archive.tar.gz?ref=${pkg_version}")
pkg_shasum=('e24f554c764079d938cab71439a2e555')

do_build() {
  cd ${pkg_name}-${pkg_version}-*

  /usr/lib/qt5/bin/qmake PREFIX=/usr LIBDIR=/usr/lib
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}-*
  
  make INSTALL_ROOT=${pkg_prefix} install
}
