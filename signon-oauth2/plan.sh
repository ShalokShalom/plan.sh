pkg_origin=

pkg_name=signon-oauth2
pkg_version=0.24
_commit=b74b5397992caddeb32a6158c9295126c55a3025
pkg_description='OAuth 2 plugin for signon'
pkg_upstream_url="https://gitlab.com/accounts-sso"
pkg_license=('LGPL')
pkg_deps=('signonqt' 'qt5-xmlpatterns')
# https://groups.google.com/forum/#!forum/accounts-sso-announce
pkg_source=("https://gitlab.com/accounts-sso/signon-plugin-oauth2/repository/archive.tar.bz2?ref=VERSION_${pkg_version}")
pkg_shasum=('5fa973a8f0fa5564bc3705ac389dc1b9')

do_build() {
  cd signon-plugin-oauth2-VERSION_${pkg_version}-*

  /usr/lib/qt5/bin/qmake PREFIX=/usr LIBDIR=/usr/lib
  make
}

do_package() {
  cd signon-plugin-oauth2-VERSION_${pkg_version}-*
  make INSTALL_ROOT=$pkg_prefix install
  
  # kaccounts-providers conflict
  rm -r $pkg_prefix/etc/signon-ui/webkit-options.d/www.facebook.com.conf
}
