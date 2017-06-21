pkg_origin=cosmos

pkg_name=openexr
pkg_version=2.2.0
pkg_description="openexr library for EXR images"
pkg_upstream_url="http://www.openexr.org"
pkg_license=('custom')
pkg_deps=('zlib' 'ilmbase')
pkg_source=("http://download.savannah.nongnu.org/releases/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('b64e931c82aa3790329c21418373db4e')

do_build() {

  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
  install -D -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
