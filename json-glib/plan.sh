pkg_origin=cosmos

pkg_name=json-glib
pkg_version=1.2.8
_pkg_version=1.2
pkg_description="Library providing serialization and deserialization support for the JavaScript Object Notation format"
pkg_upstream_url="http://live.gnome.org/JsonGlib"
pkg_license=('GPL')
pkg_deps=('glib2')
pkg_build_deps=('gobject-introspection')
pkg_source=("https://ftp.gnome.org/pub/GNOME/sources/${pkg_name}/${_pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('ff31e7d0594df44318e12facda3d086e')

do_build(){
  
  ./configure --prefix=/usr
  make
}

do_package(){
  
  make DESTDIR=${pkg_prefix} install
}

