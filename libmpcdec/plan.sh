pkg_origin=cosmos

pkg_name=libmpcdec
pkg_version=1.2.6
pkg_description="Musepack decoding library"
pkg_upstream_url="http://musepack.net/"
pkg_license=('custom')
pkg_deps=('glibc')
pkg_source=("http://files.musepack.net/source/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('7f7a060e83b4278acf4b77d7a7b9d2c0')

do_build() {
  
  ./configure --prefix=/usr --disable-static
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
  install -Dm644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/COPYING
}
