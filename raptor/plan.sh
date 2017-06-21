pkg_origin=cosmos

pkg_name=raptor
pkg_version=2.0.15
pkg_description="A C library that parses RDF/XML/N-Triples into RDF triples"
pkg_upstream_url="http://librdf.org/raptor"
pkg_deps=('libxml2' 'curl' 'zlib>=1.2.5' 'libxslt' 'icu')
pkg_license=('LGPL')
pkg_source=("http://librdf.org/dist/source/raptor2-$pkg_version.tar.gz")
pkg_shasum=('a39f6c07ddb20d7dd2ff1f95fa21e2cd')

do_build() {

  ./configure --prefix=/usr \
    --disable-static \
    --with-yajl=no \
    --with-icu-config=/usr/bin/icu-config
  make
}

do_package() {
  
  make prefix="${CACHE_PATH}"/usr install
}
