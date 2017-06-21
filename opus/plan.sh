pkg_origin=cosmos

pkg_name=opus
pkg_version=1.1.5
pkg_description="Codec designed for interactive speech and audio transmission over the Internet"
pkg_upstream_url="https://www.opus-codec.org/"
pkg_license=('custom')
pkg_deps=('glibc')
pkg_source=("https://archive.mozilla.org/pub/opus/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('57be27482872fb0e26dc1a12f392a62f')

do_build() {
  
  ./configure --prefix=/usr \
    --enable-custom-modes \
    --enable-intrinsics \
    --enable-rtcd
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -m755 -d ${pkg_prefix}/usr/share/licenses/opus
  install -m644 COPYING ${pkg_prefix}/usr/share/licenses/opus/
}
