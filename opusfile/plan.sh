pkg_origin=cosmos

pkg_name=opusfile
pkg_version=0.8
pkg_description="Provides application developers with a high-level API for decoding and seeking in .opus files"
pkg_upstream_url="http://www.opus-codec.org/"
pkg_license=('BSD')
pkg_deps=('opus' 'libogg')
pkg_source=("http://downloads.xiph.org/releases/opus/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('78ad26f75900dc8428d75e6e4256196d')

do_build() {
  
  ./configure --prefix=/usr 
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -m755 -d ${pkg_prefix}/usr/share/licenses/opusfile
  install -m644 COPYING ${pkg_prefix}/usr/share/licenses/opusfile/
}
