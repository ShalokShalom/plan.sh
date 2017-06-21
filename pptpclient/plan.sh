pkg_origin=cosmos

pkg_name=pptpclient 
pkg_version=1.9.0
pkg_description="Client for the proprietary Microsoft Point-to-Point Tunneling Protocol, PPTP."
pkg_upstream_url="http://pptpclient.sourceforge.net/"
pkg_license=('GPL')
pkg_deps=('glibc' 'ppp' 'iproute2')
backup=('etc/ppp/options.pptp')
pkg_source=("https://sourceforge.net/projects/pptpclient/files/pptp/pptp-${pkg_version}/pptp-${pkg_version}.tar.gz")
pkg_shasum=('b2117b377f65294a9786f80f0235d308')

 
do_build() { 
  cd pptp-${pkg_version}
  
  sed -i -e "/CFLAGS  =/ c\CFLAGS = ${CFLAGS}" Makefile
  sed -i -e "/LDFLAGS =/ c\LDFLAGS = ${LDFLAGS}" Makefile
  sed -i 's|\/bin\/ip|\/usr\/sbin\/ip|g' routing.c 
  
  make
}

do_package() {
  cd pptp-${pkg_version}
  
  make DESTDIR=${pkg_prefix} install
}
