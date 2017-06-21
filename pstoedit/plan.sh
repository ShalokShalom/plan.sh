pkg_origin=cosmos

pkg_name=pstoedit
pkg_version=3.70
pkg_description="Translates PostScript and PDF graphics into other vector formats"
pkg_upstream_url="http://www.pstoedit.net/"
pkg_license=('GPL')
pkg_deps=('gcc-libs' 'plotutils' 'gd' 'imagemagick')
pkg_build_deps=('ghostscript')
pkg_source=("http://downloads.sourceforge.net/sourceforge/pstoedit/pstoedit-${pkg_version}.tar.gz")
pkg_shasum=('d3ad4657b4944a8400f7ca76f78cb943')

do_build() {
  sed -i 's|-pedantic||' configure

  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${CACHE_PATH} install
}
