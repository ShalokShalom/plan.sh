pkg_origin=cosmos

pkg_name=gtkspell
pkg_version=2.0.16
pkg_upstream_url="http://gtkspell.sourceforge.net/"
pkg_description="GtkSpell provides word-processor-style highlighting and replacement of misspelled words in a GtkTextView widget"
pkg_license=('GPL')
pkg_deps=('gtk2' 'enchant')
pkg_build_deps=('intltool' 'gtk-doc')
pkg_source=("http://gtkspell.sourceforge.net/download/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('f75dcc9338f182c571b321d37c606a94')

do_build() {
  
  ./configure --prefix=/usr 
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
