pkg_origin=cosmos

pkg_name=libsamplerate
pkg_version=0.1.9
pkg_description="Secret Rabbit Code - aka Sample Rate Converter for audio"
pkg_upstream_url="http://www.mega-nerd.com/SRC/index.html"
pkg_license=('GPL')
pkg_deps=('libsndfile')
pkg_source=("http://www.mega-nerd.com/SRC/libsamplerate-${pkg_version}.tar.gz")
pkg_shasum=('2b78ae9fe63b36b9fbb6267fad93f259')

do_build() {
  
  ./configure --prefix=/usr
  make
}

check() {
  
  make check
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
