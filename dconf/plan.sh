pkg_origin=cosmos

pkg_name=dconf
pkg_version=0.26.0
_pkg_version=0.26
pkg_description="A low-level configuration system."
pkg_upstream_url="https://wiki.gnome.org/Projects/dconf"
pkg_license=('LGPL2.1')
pkg_deps=('glib2')
pkg_build_deps=('vala' 'gobject-introspection' 'python2' 'intltool' 'docbook-xsl' 'python3')
pkg_source=("https://download.gnome.org/sources/dconf/${_pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('7fc3cb1cf22d904d8744bd12e9c9d3dd')

do_build() {

  ./configure --prefix=/usr \
       --sysconfdir=/etc \
       --libexecdir=/usr/lib/dconf \
       --disable-editor
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
