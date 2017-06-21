pkg_origin=cosmos

pkg_name=iso-codes
pkg_version=3.75
pkg_description="Lists of various ISO standards (e.g. country,language, language scripts, and currency names) in one place"
pkg_upstream_url="https://pkg-isocodes.alioth.debian.org/"
pkg_license=('LGPL')
pkg_description="Lists of the country, language, and currency names"
pkg_build_deps=('python3')
pkg_source=("https://pkg-isocodes.alioth.debian.org/downloads/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('9ba173b69d4360003414f23837597a92')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} pkgconfigdir=/usr/lib/pkgconfig install
}
