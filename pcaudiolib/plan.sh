pkg_origin=cosmos

pkg_name=pcaudiolib
pkg_version=1.0
_commit=8a013933f66b58c18e94eae9108fd573467f792b
pkg_description="Portable C Audio Library provides a C API to different audio devices."
pkg_upstream_url="https://github.com/rhdunn/pcaudiolib"
pkg_license=('GPL3')
pkg_deps=('pulseaudio' 'alsa-lib')
pkg_source=("https://github.com/rhdunn/pcaudiolib/archive/${_commit}.zip")
pkg_shasum=('9bbbd9c45c906b694d84498204ef172d')


do_build() {
  
  ./autogen.sh
  ./configure --prefix=/usr
  
  make -j1 
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
