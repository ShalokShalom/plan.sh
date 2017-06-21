pkg_origin=cosmos

pkg_name=libtimezonemap
pkg_version=0.4.3
pkg_description="GTK+3 timezone map widget"
pkg_upstream_url="https://launchpad.net/libtimezonemap"
pkg_license=('GPL')
pkg_deps=('gtk3' 'json-glib')
pkg_build_deps=('gobject-introspection' 'intltool')
pkg_source=("https://launchpad.net/ubuntu/+archive/primary/+files/${pkg_name}_${pkg_version}.tar.gz")
pkg_shasum=('30caa760d9d3e27f7c54e2fe289784d6')

do_build() {
  
   autoreconf -vfi
   ./configure --prefix=/usr --enable-introspection 
   make
}

do_package() {
  
   make DESTDIR="${pkg_prefix}/" install
}


