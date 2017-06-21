pkg_origin=cosmos

pkg_name=pango
pkg_version=1.40.6
_pkg_version=1.40
pkg_description="A library for layout and rendering of text"
pkg_upstream_url="http://www.pango.org/"
pkg_license=('LGPL')
pkg_deps=('cairo' 'libxft' 'libthai' 'harfbuzz')
pkg_build_deps=('gobject-introspection' 'libxt' 'fontconfig')
pkg_source=("https://download.gnome.org/sources/pango/${_pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('507c6746fbf53fc9d48c577f1e265de3')

do_build() {

  ./configure --prefix=/usr \
        --sysconfdir=/etc \
        --localstatedir=/var 
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -m755 -d ${pkg_prefix}/etc/pango
}
