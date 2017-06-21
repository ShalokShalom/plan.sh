pkg_origin=cosmos

# rebuild cups-filters on every update, but point update
pkg_name=qpdf
pkg_version=6.0.0
pkg_description="QPDF: A Content-Preserving PDF Transformation System"
pkg_upstream_url="http://qpdf.sourceforge.net/"
pkg_license=('custom:Artistic-2.0')
pkg_deps=('pcre' 'perl')
pkg_build_deps=('make')
pkg_source=("http://downloads.sourceforge.net/qpdf/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('e014bd3ecf1c4d1a520bbc14d84ac20e')

do_build() {

  ./configure --prefix=/usr --disable-static
  make
}


do_package() {
  
  make DESTDIR=${CACHE_PATH}/ install

  mkdir -m755 -p ${CACHE_PATH}/usr/share/licenses/${pkg_name}
  install -m644 Artistic-2.0 ${CACHE_PATH}/usr/share/licenses/${pkg_name}/
}
