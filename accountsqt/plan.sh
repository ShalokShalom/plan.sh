pkg_origin=cosmos

pkg_name=accountsqt
pkg_version=1.15
_pkg_version=VERSION_1.14-a34ca4b6d250529c900b0382559553b6e5885918
pkg_description="Accounts & SSO framework consists of a set of components and libraries which implement
         an account manager for a user's online accounts and a single-sign-on daemon"
pkg_upstream_url="https://gitlab.com/groups/accounts-sso"
pkg_license=('LGPL')
pkg_deps=('qt5-base' 'libaccounts-glib')
pkg_build_deps=('doxygen')
pkg_source=("https://gitlab.com/accounts-sso/libaccounts-qt/repository/archive.tar.bz2?ref=VERSION_${pkg_version}")
pkg_shasum=('e42c66030610d00f48a8c2c1ffc3ebe2') 

do_build() {
  #sed -i 's|SUBDIRS  += Accounts tests|SUBDIRS += Accounts|' accounts-qt.pro
  #sed -i 's|QHG_LOCATION           = qhelpgenerator|QHG_LOCATION = qhelpgenerator-qt5|' doc/doxy.conf

  /usr/lib/qt5/bin/qmake PREFIX=/usr LIBDIR=/usr/lib
  make
}

do_package() {

  make INSTALL_ROOT=${pkg_prefix} install_subtargets
}
