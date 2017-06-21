pkg_origin=cosmos

pkg_name=ortp
pkg_version=0.25.0
pkg_description="A Real-time Transport Protocol (RTP) library"
pkg_upstream_url="http://www.linphone.org/index.php/eng/code_review/ortp"
pkg_license=('LGPL')
pkg_deps=('libsrtp')
pkg_source=("http://savannah.spinellicreations.com/linphone/ortp/sources/$pkg_name-$pkg_version.tar.gz")
pkg_shasum=('f44b4ab2a8de32c19abfa584c4426f76')

do_build() {
  
  ./configure --prefix=/usr
  make 
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
