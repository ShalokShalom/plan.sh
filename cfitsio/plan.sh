pkg_origin=cosmos

pkg_name=cfitsio
pkg_version=3.410
_pkg_version=3410
pkg_description="Library for reading and writing data files in FITS (Flexible Image Transport System) data format."
pkg_upstream_url="http://heasarc.gsfc.nasa.gov/docs/software/fitsio/fitsio.html"
pkg_license=('GPL2')
pkg_deps=('glibc')
pkg_build_deps=('pkgconfig')
pkg_source=("ftp://heasarc.gsfc.nasa.gov/software/fitsio/c/${pkg_name}${_pkg_version}.tar.gz")
pkg_shasum=('8a4a66fcdd816aae41768baa0b025552')

do_build() {
  
  ./configure --prefix=/usr
  make shared
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -D -m644 License.txt ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
