pkg_origin=cosmos

pkg_name=gutenprint
pkg_version=5.2.12
pkg_description="Top quality printer drivers for POSIX systems."
pkg_upstream_url="http://gimp-print.sourceforge.net/"
pkg_license=('GPL')
pkg_deps=('glibc' 'cups' 'ghostscript' )
pkg_build_deps=('foomatic-db-engine' )
pkg_deps=('foomatic-db-engine:	to use foomatic spooler')
install=gutenprint.install
pkg_source=("http://downloads.sourceforge.net/gimp-print/$pkg_name-$pkg_version.tar.bz2")
pkg_shasum=('44cdff6784a0f6b0bd83d69e23dfdcb8')

do_build() {

  ./configure --prefix=/usr \
    --disable-samples \
    --with-cups \
	--disable-translated-cups-ppds \
	--enable-cups-ppds \
	--enable-cups-ppds-at-top-level \
	--disable-globalized-cups-ppds
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}

