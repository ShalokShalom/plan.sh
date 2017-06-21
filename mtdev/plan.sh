pkg_origin=cosmos

pkg_name=mtdev
pkg_version=1.1.5
pkg_description="A stand-alone library which transforms all variants of kernel MT events to the slotted type B protocol"
pkg_upstream_url="http://bitmath.org/code/mtdev"
pkg_license=('custom:MIT')
pkg_deps=('glibc')
pkg_source=("http://bitmath.org/code/mtdev/$pkg_name-$pkg_version.tar.bz2")
pkg_shasum=('52c9610b6002f71d1642dc1a1cca5ec1')

do_build() {
  
  ./configure --prefix=/usr --disable-static
  make
}

check() {
  
  make -k check
}

do_package() {
  make DESTDIR="$pkg_prefix/" install

  install -Dm644 COPYING "$pkg_prefix/usr/share/licenses/$pkg_name/LICENSE"
}

