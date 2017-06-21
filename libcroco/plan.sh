pkg_origin=cosmos

pkg_name=libcroco
pkg_version=0.6.12
pkg_description="A CSS parsing library"
pkg_upstream_url="http://www.gnome.org"
pkg_deps=('glib2' 'libxml2')
pkg_build_deps=('intltool')
pkg_license=('LGPL')
pkg_source=("http://ftp.gnome.org/pub/gnome/sources/libcroco/0.6/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('bc0984fce078ba2ce29f9500c6b9ddce')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  ./configure --prefix=/usr --disable-static
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  
  make DESTDIR=${pkg_prefix} install
}
