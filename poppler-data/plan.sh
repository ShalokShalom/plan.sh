pkg_origin=cosmos

pkg_name=poppler-data
pkg_version=0.4.7
pkg_description="Encoding data for the poppler PDF rendering library"
pkg_upstream_url="http://poppler.freedesktop.org/"
pkg_license=('custom' 'GPL2')
pkg_source=("http://poppler.freedesktop.org/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('636a8f2b9f6df9e7ced8ec0946961eaf')

do_package() {
  make prefix=/usr DESTDIR=${pkg_prefix} install

  install -m755 -d ${pkg_prefix}/usr/share/licenses/${pkg_name}
  install -m644 COPYING COPYING.adobe ${pkg_prefix}/usr/share/licenses/${pkg_name}/
}
