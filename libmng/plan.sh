pkg_origin=cosmos

pkg_name=libmng
pkg_version=2.0.3
pkg_description="Collection of routines used to create and manipulate MNG format graphics files"
pkg_upstream_url="http://www.libmng.com/"
pkg_license=('custom')
pkg_deps=('zlib' 'libjpeg-turbo' 'lcms2')
pkg_source=("https://downloads.sourceforge.net/sourceforge/libmng/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('e9e899adb1b681b17f14d91e261878c5')

do_build() {
 
  autoreconf --force --install
  ./configure --prefix=/usr --with-lcms2
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
  install -D -m644 LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
