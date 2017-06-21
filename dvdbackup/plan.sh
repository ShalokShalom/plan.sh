pkg_origin=

pkg_name=dvdbackup
pkg_version=0.4.2
pkg_description="Tool to rip video DVDs from the command line"
pkg_upstream_url="http://dvdbackup.sourceforge.net"
pkg_license=('GPL')
pkg_deps=('libdvdread')
optpkg_deps=('libdvdcss: to decrypt encrypted DVDs')
pkg_source=("https://downloads.sourceforge.net/dvdbackup/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('28f273b2f27a3afea3a3c965ddbede86')

do_build() {
  cd ${pkg_name}-${pkg_version}

  ./configure --prefix=/usr

  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}

  make DESTDIR=${pkg_prefix}/ install
}
