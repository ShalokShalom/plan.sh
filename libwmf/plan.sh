pkg_origin=cosmos

pkg_name=libwmf
pkg_version=0.2.8.4
pkg_description="A library for reading vector images in Microsoft's native Windows Metafile Format (WMF)."
pkg_upstream_url="http://wvware.sourceforge.net/libwmf.html"
pkg_license=("LGPL")
pkg_deps=('libpng' 'libx11' 'freetype2' 'libjpeg-turbo' 'gsfonts' 'expat>=2.0')
pkg_build_deps=('pkgconfig')
pkg_source=("http://downloads.sourceforge.net/sourceforge/wvware/${pkg_name}-${pkg_version}.tar.gz"
	'libwmf-0.2.8.4-libpng-1.5.patch')
pkg_shasum=('d1177739bf1ceb07f57421f0cee191e0'
         '21bab2d951aef8e72805eacee950cb09')

do_build() {
  patch -p1 -i ${CACHE_PATH}/libwmf-0.2.8.4-libpng-1.5.patch 
  
  sed -i -e 's/src include fonts doc/src include fonts/g' Makefile.in
  ./configure --prefix=/usr \
              --with-gsfontdir=/usr/share/fonts/Type1 \
              --with-fontdir=/usr/share/fonts/Type1 \
              --with-gsfontmap=/usr/share/ghostscript/9.14/Resources/Init/Fontmap.GS \
              --disable-gtk2
  make 
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
  #Part of gsfonts
  rm -rf ${pkg_prefix}/usr/share/fonts

  rm -f ${pkg_prefix}/usr/lib/gtk-2.0/*/loaders/*.a
}
