pkg_origin=cosmos

pkg_name=libqalculate
pkg_version=0.9.12
pkg_description="Multi-purpose desktop calculator"
pkg_upstream_url="http://qalculate.github.io/"
pkg_license=('GPL')
pkg_deps=('libxml2' 'cln' 'glib2' 'ncurses' 'readline')
pkg_build_deps=('perl-xml-parser' 'intltool')
pkg_deps=('gnuplot: for plotting support')
pkg_source=("https://github.com/Qalculate/libqalculate/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('f4f740c694751774a087af7032200c01')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
