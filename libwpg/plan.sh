pkg_origin=cosmos

pkg_name=libwpg
pkg_version=0.3.1
pkg_description="Library for importing and converting Corel WordPerfect(tm) Graphics images."
pkg_upstream_url="http://libwpg.sourceforge.net/"
pkg_license=('LGPL')
pkg_deps=('libwpd' 'perl' 'librevenge')
pkg_source=("http://downloads.sourceforge.net/libwpg/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('62cf22e05cc6afa3f7384e9487cd255d')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
