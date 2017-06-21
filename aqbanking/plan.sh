pkg_origin=cosmos

pkg_name=aqbanking
pkg_version=5.6.12
_dnrel=208
pkg_description="A library for online banking and financial applications"
pkg_upstream_url="http://www.aquamaniac.de/aqbanking"
pkg_license=('GPL')
pkg_deps=('gwenhywfar' 'ktoblzcheck' 'libofx')
pkg_source=("aqbanking-${pkg_version}.tar.gz::http://www2.aquamaniac.de/sites/download/download.php?package=03&release=${_dnrel}&file=01&dummy=aqbanking-${pkg_version}.tar.gz")
pkg_shasum=('f4476db215fe08c73d35b2018cf24739')

do_build() {
  export PKG_CONFIG=/usr/bin/pkg-config
  
  ./configure --prefix=/usr \
	    --with-backends="aqhbci aqofxconnect" \
	    --enable-gwenhywfar
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}


