pkg_origin=cosmos

pkg_name=writerperfect
pkg_version=0.9.1
pkg_description="libwpd utilities for converting WordPerfect(tm) and Visio(tm) documents to odt and odg"
pkg_upstream_url="http://sourceforge.net/projects/libwpd"
pkg_license=('LGPL')
pkg_deps=('libwpd' 'libwpg' 'libwps' 'libvisio' 'libgsf' 'librevenge')
pkg_build_deps=('libtool' 'glib2')
pkg_source=("http://downloads.sourceforge.net/project/libwpd/$pkg_name/$pkg_name-$pkg_version/$pkg_name-$pkg_version.tar.xz")
pkg_shasum=('a6c624072e662e721382f9af1d818e74')

do_build() {

   ./autogen.sh
   ./configure --prefix=/usr --disable-werror
   make 
}

do_package() {

  make DESTDIR="$CACHE_PATH" install
}
