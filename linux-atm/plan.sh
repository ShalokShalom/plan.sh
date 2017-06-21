pkg_origin=cosmos

pkg_name=linux-atm
pkg_version=2.5.2
pkg_description="Drivers and tools to support ATM networking under Linux."
pkg_upstream_url="http://linux-atm.sourceforge.net/"
pkg_license=('GPL')
pkg_deps=('glibc')
pkg_source=("http://downloads.sourceforge.net/sourceforge/linux-atm/$pkg_name-$pkg_version.tar.gz")
pkg_shasum=('d49499368c3cf15f73a05d9bce8824a8')

do_build() {
  cd $pkg_name-$pkg_version 
  sed -i "s|/lib/firmware|/usr/lib/firmware|" src/extra/Makefile.in
  
  ./configure --prefix=/usr --sysconfdir=/etc 
  make 
}

do_package() {
  cd $pkg_name-$pkg_version
  
  make DESTDIR=$pkg_prefix install
}

