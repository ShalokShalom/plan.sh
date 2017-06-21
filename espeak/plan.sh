pkg_origin=cosmos

pkg_name=espeak
pkg_version=1.49.1
pkg_description="Text to Speech engine for good quality English, with support for other languages"
pkg_upstream_url="https://groups.io/g/espeak-ng/"
pkg_license=('GPL')
pkg_deps=('gcc-libs' 'portaudio' 'pulseaudio' 'pcaudiolib')
pkg_source=("https://github.com/espeak-ng/espeak-ng/releases/download/${pkg_version}/${pkg_name}-ng-${pkg_version}.tar.gz")
pkg_shasum=('ce76fc552fe32087987d4c09354e4cb7')


do_build() {
  
  ./configure --prefix=/usr
  
  make -j1 
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  chmod 644 ${pkg_prefix}/usr/lib/libespeak-ng.a
}
