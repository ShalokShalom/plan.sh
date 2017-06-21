pkg_origin=cosmos

pkg_name=ftgl
pkg_version=2.1.3rc5
_pkg_version=2.1.3-rc5
_buildver=2.1.3~rc5
pkg_description="OpenGL library to use arbitrary fonts"
pkg_upstream_url="http://ftgl.wiki.sourceforge.net/"
pkg_license=('MIT')
pkg_deps=('freetype2' 'glu')
pkg_build_deps=('doxygen' 'mesa')
pkg_source=("http://downloads.sourceforge.net/ftgl/${pkg_name}-${_pkg_version}.tar.bz2")
pkg_shasum=('c7879018cde844059495b3029b0b6503')

do_build() {
  sed -i '/^SUBDIRS =/s/demo//' Makefile.in
  
  ./configure --prefix=/usr --with-pic --disable-static
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -m644 src/FT{Face,Library,Size}.h $pkg_prefix/usr/include/FTGL/
  install -Dm644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
