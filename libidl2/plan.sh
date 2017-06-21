pkg_origin=cosmos

pkg_name=libidl2
pkg_version=0.8.14
_pkg_version=0.8
pkg_description="Front-end for CORBA 2.2 IDL and Netscape's XPIDL"
pkg_upstream_url="https://www.gnome.org"
pkg_license=('LGPL')
pkg_deps=('glib2' 'texinfo')
pkg_build_deps=('pkgconfig')
pkg_source=("https://ftp.gnome.org/pub/gnome/sources/libIDL/${_pkg_version}/libIDL-${pkg_version}.tar.bz2")
pkg_shasum=('bb8e10a218fac793a52d404d14adedcb')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
