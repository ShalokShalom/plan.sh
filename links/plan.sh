pkg_origin=

pkg_name=links
pkg_version=2.14
pkg_description="A text WWW browser, similar to Lynx"
pkg_upstream_url="http://links.twibright.com/"
pkg_license=('GPL')
pkg_deps=('bzip2' 'xz' 'zlib' 'openssl' 'gpm')
pkg_build_deps=('libtiff' 'libpng' 'libxt')
optpkg_deps=('libx11: for using xlinks'
            'libtiff: for using xlinks'
            'libpng: for using xlinks')
pkg_source=("http://links.twibright.com/download/${pkg_name}-${pkg_version}.tar.bz2"
        'links.desktop')
pkg_shasum=('0d11b388de22ba280008a36a409a34c6'
         '7c47b15aaef51f1de129ff3a2afb7eac')

do_build() {
  cd ${pkg_name}-${pkg_version}
  (cd intl; ./gen-intl; ./synclang)
  
  ./configure --prefix=/usr \
        --mandir=/usr/share/man \
        --enable-javascript \
        --enable-graphics \
        --with-x \
        --with-fb
  make
  mv links xlinks

  ./configure --prefix=/usr \
         --mandir=/usr/share/man \
         --enable-javascript \
         --disable-graphics \
         --without-x \
         --without-fb
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix} install

  install -m755 xlinks ${pkg_prefix}/usr/bin/xlinks
  ln -s links.1.gz ${pkg_prefix}/usr/share/man/man1/xlinks.1.gz

  install -D -m644 ${CACHE_PATH}/links.desktop ${pkg_prefix}/usr/share/applications/links.desktop
  install -d ${pkg_prefix}/usr/share/pixmaps
  install -m644 links_16x16_1.xpm links_16x16_2.xpm links_32x32.xpm ${pkg_prefix}/usr/share/pixmaps/

  install -d ${pkg_prefix}/usr/share/doc/links/calibration
  install -m644 doc/links_cal/* ${pkg_prefix}/usr/share/doc/links/calibration/
}
