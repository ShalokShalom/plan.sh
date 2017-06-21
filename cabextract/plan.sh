pkg_origin=cosmos

pkg_name=cabextract
pkg_version=1.4
pkg_description="A program to extract Microsoft cabinet (.CAB) files."
pkg_license=('GPL')
pkg_upstream_url="http://www.cabextract.org.uk/"
pkg_deps=('glibc')
pkg_source=("http://www.cabextract.org.uk/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('79f41f568cf1a3ac105e0687e8bfb7c0')

do_build() {

  ./configure --prefix=/usr \
              --sysconfdir=/etc \
              --mandir=/usr/share/man
  make
}

do_package() {
  
  make DESTDIR="${pkg_prefix}" install
}
