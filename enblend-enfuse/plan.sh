pkg_origin=cosmos

pkg_name=enblend-enfuse
pkg_version=4.2
pkg_description="Intelligent blend tool for overlapping picture"
pkg_license=('GPL')
pkg_upstream_url="http://enblend.sourceforge.net"
pkg_deps=('openexr' 'lcms2' 'libpng' 'vigra' 'gsl')
pkg_build_deps=('boost' 'mesa' 'help2man' 'texlive-latexextra')
pkg_source=("http://downloads.sourceforge.net/sourceforge/enblend/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('e26751f393862cecfd1a113003787001')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
