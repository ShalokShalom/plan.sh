pkg_origin=cosmos

pkg_name=liblqr
pkg_version=0.4.2
pkg_description="A seam-carving C/C++ library called Liquid Rescale"
pkg_upstream_url="http://liblqr.wikidot.com/"
pkg_license=('GPL')
pkg_deps=('glibc' 'glib2')
pkg_build_deps=('pkgconfig')
pkg_source=("https://github.com/carlobaldassi/liblqr/archive/v$pkg_version.tar.gz")
pkg_shasum=('f7b4ecddd8a038f057e236347fd7767c')

do_build() {
  
  ./configure --prefix=/usr 
  make 
}

do_package() {

  make DESTDIR=$pkg_prefix/ install 
}

