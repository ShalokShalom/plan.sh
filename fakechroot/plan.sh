pkg_origin=cosmos

pkg_name=fakechroot
pkg_version=2.19
pkg_description="Gives a fake chroot environment"
pkg_upstream_url="https://github.com/dex4er/fakechroot"
pkg_license=('LGPL')
install=fakechroot.install
pkg_source=("http://ftp.debian.org/debian/pool/main/f/fakechroot/${pkg_name}_${pkg_version}.orig.tar.gz")
pkg_shasum=('db6378420c769232e69508bb78612c34')

do_build() {
  
  ./configure --prefix=/usr --libdir=/usr/lib/libfakeroot --sysconfdir=/etc
  make 
}

check() {
  
  make check
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -dm755 ${pkg_prefix}/etc/ld.so.conf.d/
  echo '/usr/lib/libfakeroot/fakechroot/' > ${pkg_prefix}/etc/ld.so.conf.d/fakechroot.conf
}
