pkg_origin=cosmos

pkg_name=rasqal
pkg_version=0.9.33
pkg_description="Free C library that handles Resource Description Framework (RDF) query syntaxes, query construction and query execution returning result bindings"
pkg_upstream_url="http://librdf.org/rasqal"
pkg_license=('GPL' 'LGPL')
pkg_deps=('raptor' 'mpfr' 'util-linux' 'libgcrypt')
pkg_source=("http://download.librdf.org/source/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('1f5def51ca0026cd192958ef07228b52')

do_build() {
  
  ./configure --prefix=/usr \
	--disable-static \
	--enable-release
  make
}

do_package() {
  
  make DESTDIR=${CACHE_PATH} install
}
