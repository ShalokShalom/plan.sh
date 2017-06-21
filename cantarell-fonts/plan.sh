pkg_origin=cosmos

pkg_name=cantarell-fonts
pkg_version=0.0.25
_pkg_version=0.0
pkg_description="The Cantarell typeface family is a contemporary Humanist sans serif"
pkg_upstream_url="https://git.gnome.org/browse/cantarell-fonts/tree/README"
pkg_license=('GPL2')
pkg_deps=('fontconfig')
install=cantarell-fonts.install
pkg_source=("http://download.gnome.org/sources/cantarell-fonts/${_pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('8fa68460bb292b9c9441af10f99d99d7')

do_build() {

  ./configure --prefix=/usr --with-configdir=/etc/fonts/conf.avail
  make
}

do_package() {

  make DESTDIR=${pkg_prefix} install
}
