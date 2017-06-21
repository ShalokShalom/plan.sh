pkg_origin=cosmos

pkg_name=epson-inkjet-printer-escpr
pkg_version=1.6.13
pkg_description="Common Linux printer driver for Epson Multifonction Inkjet Printers."
pkg_upstream_url="https://www.epson.com"
pkg_license=('GPL')
pkg_deps=('cups' 'gutenprint')
# http://download.ebz.epson.net/dsc/search/01/search/
pkg_source=("https://download3.ebz.epson.net/dsc/f/03/00/05/55/39/d16f39e5f8953e033f6f38083b38c50c543b891c/${pkg_name}-${pkg_version}-1lsb3.2.tar.gz")
pkg_shasum=('dec25ff5ef83f1627d75202dd5ee7ffb')

do_build() {
  tar xzvf ${pkg_name}-${pkg_version}-1lsb3.2.tar.gz
  
  
  ./configure --prefix=/usr \
              --sysconfdir=/etc \
              --localstatedir=/var \
              --libexecdir=/usr/lib
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
