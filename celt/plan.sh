pkg_origin=cosmos

pkg_name=celt
pkg_version=0.11.3
pkg_description="Low-latency audio communication codec"
pkg_upstream_url="http://www.celt-codec.org"
pkg_license=('BSD')
pkg_deps=('libogg')
pkg_source=("http://downloads.us.xiph.org/releases/$pkg_name/$pkg_name-$pkg_version.tar.gz")
pkg_shasum=('5511732a426cc42bf986ca79b5cdd02f')

do_build() {

  ./configure  --prefix=/usr --enable-custom-modes
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -Dm644 COPYING "$pkg_prefix/usr/share/licenses/$pkg_name/LICENSE"
}

