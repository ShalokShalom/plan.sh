pkg_origin=cosmos

pkg_name=glib-networking
pkg_version=2.50.0
_pkg_version=2.50
pkg_description="Network-related giomodules for glib"
pkg_upstream_url="http://www.gtk.org/"
pkg_license=('GPL2')
pkg_deps=('glib2' 'libproxy' 'gnutls' 'ca-certificates' 'libtasn1')
pkg_build_deps=('intltool')
pkg_source=("https://download.gnome.org/sources/glib-networking/${_pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('4d06d0224646f274918b1cb6da9a07f6')

do_build() {
  
  ./configure --prefix=/usr \
        --sysconfdir=/etc \
        --libexecdir=/usr/lib/${pkg_name} \
        --disable-static \
        --disable-installed-tests
  make
}

check() {
  
  make -k check
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install testfiles_DATA=
}

