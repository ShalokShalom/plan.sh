pkg_origin=cosmos

pkg_name=openconnect
pkg_version=7.08
pkg_description="Open client for Cisco AnyConnect VPN"
pkg_license=('GPL')
pkg_upstream_url="http://www.infradead.org/openconnect.html"
pkg_deps=('libxml2' 'gnutls' 'libproxy' 'vpnc' 'libtasn1')
pkg_build_deps=('intltool' 'python2')
pkg_source=("ftp://ftp.infradead.org/pub/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('ca2ca1f61b8515879b481dcf6ed4366b')

do_build() {
  
  ./configure --prefix=/usr --disable-static
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
