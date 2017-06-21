pkg_origin=cosmos

pkg_name=sysfsutils
pkg_version=2.1.0
pkg_description="System Utilities Based on Sysfs"
pkg_license=('GPL' 'LGPL')
pkg_upstream_url="http://linux-diag.sourceforge.net/Sysfsutils.html"
pkg_deps=('glibc')
pkg_source=("http://downloads.sourceforge.net/sourceforge/linux-diag/$pkg_name-$pkg_version.tar.gz")
pkg_shasum=('14e7dcd0436d2f49aa403f67e1ef7ddc')

do_build() {
  cd $pkg_name-$pkg_version
  
  ./configure --prefix=/usr --mandir=/usr/share/man
  make
}

do_check() {
  cd $pkg_name-$pkg_version
  
  make check
}

do_package() {
  cd $pkg_name-$pkg_version
  
  make DESTDIR=$pkg_prefix install
  rm $pkg_prefix/usr/lib/libsysfs.a
}

