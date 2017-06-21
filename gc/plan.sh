pkg_origin=cosmos

pkg_name=gc
pkg_version=7.6.0
_pkg_version=7.6.0
pkg_description="A garbage collector for C and C++"
pkg_upstream_url="http://www.hboehm.info/gc/"
pkg_license=('GPL')
pkg_deps=('gcc-libs' 'libatomic_ops')
pkg_source=("http://www.hboehm.info/gc/gc_source/${pkg_name}-${_pkg_version}.tar.gz")
pkg_shasum=('bf46ccbdaccfa3186c2ab87191c8855a')

do_build() {
  sed -i 's|pkgdata|doc|' doc/doc.am
  
  autoreconf -fi
  ./configure --prefix=/usr --enable-cplusplus --disable-static
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  sed -i -e 's/GC_MALLOC 1L/gc 3/' doc/gc.man
  install -m755 -d ${pkg_prefix}/usr/share/man/man3
  install -m644 doc/gc.man ${pkg_prefix}/usr/share/man/man3/gc.3
}
