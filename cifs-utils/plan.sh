pkg_origin=cosmos

pkg_name=cifs-utils
pkg_version=6.7
pkg_description="CIFS filesystem user-space tools"
pkg_upstream_url="http://wiki.samba.org/index.php/LinuxCIFS_utils"
pkg_license=('GPL')
pkg_deps=('libcap' 'keyutils' 'krb5' 'talloc')
pkg_build_deps=('samba')
oppkg_deps=('samba: for cifs.idmap and cifsacl')
pkg_source=("https://ftp.samba.org/pub/linux-cifs/cifs-utils/$pkg_name-$pkg_version.tar.bz2")
pkg_shasum=('af3ae1d27aca624c4daac5bf3eb0d4c1')

do_build() {

  autoreconf -i
  ./configure --prefix=/usr --disable-systemd
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} ROOTSBINDIR=/usr/bin install
  
  # mount.cifs uid, for root mounting fstab
  chmod +s $pkg_prefix/usr/bin/mount.cifs
}
