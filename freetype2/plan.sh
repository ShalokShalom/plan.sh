pkg_origin=cosmos

pkg_name=freetype2
pkg_version=2.8
pkg_description="TrueType font rendering library"
pkg_license=('GPL')
pkg_upstream_url="https://www.freetype.org/"
pkg_deps=('zlib' 'sh' 'bzip2')
pkg_source=("https://sourceforge.net/projects/freetype/files/freetype2/${pkg_version}/freetype-${pkg_version}.tar.bz2"
        'freetype-2.3.0-enable-spr.patch')
pkg_shasum=('2413ac3eaf508ada019c63959ea81a92'
         '0e968faa7c82747b0d4816749b5baad1')

do_build() {
  cd freetype-${pkg_version}
  patch -p1 -i ${CACHE_PATH}/freetype-2.3.0-enable-spr.patch

  ./configure --prefix=/usr --disable-static --without-png
  make
}

do_check() {
  cd freetype-${pkg_version}
  
  make -k check
}

do_package() {
  cd freetype-${pkg_version}

  make DESTDIR=${pkg_prefix} install
}


