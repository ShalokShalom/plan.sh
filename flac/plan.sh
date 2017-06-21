pkg_origin=cosmos

pkg_name=flac
pkg_version=1.3.2
pkg_description="Free Lossless Audio Codec"
pkg_upstream_url="https://xiph.org/flac/"
pkg_license=('custom:Xiph' 'LGPL' 'GPL' 'FDL')
pkg_deps=('libogg')
pkg_build_deps=('nasm') 
pkg_source=("https://sourceforge.net/projects/flac/files/flac-src/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('454f1bfa3f93cc708098d7890d0499bd')

do_build() {
  
  ./configure --prefix=/usr \
        --mandir=/usr/share/man \
        --enable-shared \
        --disable-sse \
        --disable-rpath \
        --with-pic
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -D -m644 COPYING.Xiph ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
