pkg_origin=cosmos

pkg_name=cups-filters
pkg_version=1.14.0
pkg_description="OpenPrinting CUPS Filters"
pkg_upstream_url="http://www.linuxfoundation.org/collaborate/workgroups/openprinting"
pkg_license=('GPL')
pkg_deps=('lcms2' 'poppler' 'qpdf')
pkg_build_deps=('ghostscript' 'ttf-dejavu' 'python3') 
pkg_deps=('ghostscript: for non-PostScript printers to print with CUPS to convert PostScript to raster images'
            'foomatic-db: drivers use Ghostscript to convert PostScript to a printable form directly'
            'foomatic-db-engine: drivers use Ghostscript to convert PostScript to a printable form directly'
            'foomatic-db-nonfree: drivers use Ghostscript to convert PostScript to a printable form directly')
backup=(etc/fonts/conf.d/99pdftoopvp.conf)
pkg_source=("https://www.openprinting.org/download/cups-filters/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('4be15231df45312cf2be7d44206286c3')

do_build() {
  #patch -p1 -i ${CACHE_PATH}/poppler34.diff
  
  ./configure --prefix=/usr  \
    --sysconfdir=/etc \
    --with-rcdir=no \
    --enable-avahi \
    --with-test-font-path=/usr/share/fonts/TTF/DejaVuSans.ttf \
    --disable-mutool
  make
}

check() {
  
  make -k check
}

do_package() {
  make DESTDIR=$pkg_prefix/ install

  rm -f ${pkg_prefix}/usr/lib/*.a
  # systemd service
  install -Dm644 utils/cups-browsed.service ${pkg_prefix}/usr/lib/systemd/system/cups-browsed.service
  sed -i 's|cups.service|org.cups.cupsd.service|g' ${pkg_prefix}/usr/lib/systemd/system/cups-browsed.service
}
