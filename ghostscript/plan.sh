pkg_origin=cosmos

## rebuild groff on every update
pkg_name=ghostscript
pkg_version=9.21
_pkg_version=921
pkg_description="An interpreter for the PostScript language"
pkg_license=('GPL3' 'custom')
pkg_deps=('libxt' 'libcups' 'fontconfig' 'zlib' 'libpng' 'libjpeg-turbo'
         'libtiff' 'lcms2' 'libpaper' 'libxext')
pkg_build_deps=('gnutls')
pkg_deps=('texlive-core:      needed for dvipdf')
pkg_upstream_url="http://www.ghostscript.com/"
#pkg_source=("http://downloads.ghostscript.com/public/ghostscript-${pkg_version}.tar.bz2")
pkg_source=("https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs${_pkg_version}/ghostscript-${pkg_version}.tar.xz")
pkg_shasum=('631beea7aa1f70f2cdca14e0308b8801')

do_build() {

  # force it to use system-libs
  rm -rf jpeg tiff freetype lcms2 libpng expat

  ./configure --prefix=/usr \
	--enable-dynamic \
	--with-jbig2dec \
	--with-x \
	--with-fontpath=/usr/share/fonts/Type1:/usr/share/fonts \
	--without-luratech \
	--disable-compile-inits \
	--with-system-libtiff \
	--disable-gtk 

  make
  
  # Build IJS
  sed -i "s:AM_PROG_CC_STDC:AC_PROG_CC:g" configure.ac
  
  ./autogen.sh
  ./configure --prefix=/usr --enable-shared --disable-static
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} \
	cups_serverroot=${pkg_prefix}/etc/cups \
	cups_serverbin=${pkg_prefix}/usr/lib/cups install soinstall
  
  mkdir -p ${pkg_prefix}/usr/share/licenses/${pkg_name}
  install -m644 LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/

  # remove unwanted localized man-pages
  rm -rf $pkg_prefix/usr/share/man/[^man1]*

  # install IJS
  make DESTDIR=${pkg_prefix} install
  
  # cups-filters 1.36 conflict
  rm -rf $pkg_prefix/usr/lib/cups/filter/{gstopxl,gstoraster}
}
