pkg_origin=cosmos

pkg_name=flickcurl
pkg_version=1.26
pkg_description="C library for the Flickr, handling creating the requests, signing, token management and calling the API"
pkg_upstream_url="http://librdf.org/flickcurl/"
pkg_license=('GPL')
pkg_deps=('raptor' 'curl')
pkg_source=("http://download.dajobe.org/flickcurl/flickcurl-${pkg_version}.tar.gz")
pkg_shasum=('7013a36656400dac398748a374c9104f')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix}/ install
}
