pkg_origin=cosmos

pkg_name=cups-pdf
pkg_version=3.0.1
pkg_description="PDF printer for cups"
pkg_upstream_url="http://www.cups-pdf.de/"
pkg_deps=('cups' 'ghostscript')
install=cups-pdf.install
pkg_license=('GPL2')
backup=('etc/cups/cups-pdf.conf')
pkg_source=("http://www.cups-pdf.de/src/cups-pdf_${pkg_version}.tar.gz")
pkg_shasum=('5071bf192b9c6eb5ada4337b6917b939')

do_build() {
  [ -z "$CC" ] && CC=gcc
  $CC $CFLAGS -O9 -s cups-pdf.c -o cups-pdf -lcups
}

do_package() {
  install -D -m700 cups-pdf ${pkg_prefix}/usr/lib/cups/backend/cups-pdf
  install -D -m 644 ../README ${pkg_prefix}/usr/share/doc/${pkg_name}/README

  install -D -m644 CUPS-PDF_opt.ppd ${pkg_prefix}/usr/share/cups/model/CUPS-PDF_opt.ppd
  install -D -m644 CUPS-PDF_noopt.ppd ${pkg_prefix}/usr/share/cups/model/CUPS-PDF_noopt.ppd
  install -D -m644 cups-pdf.conf ${pkg_prefix}/etc/cups/cups-pdf.conf
}
