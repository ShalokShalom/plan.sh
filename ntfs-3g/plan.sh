pkg_origin=cosmos

pkg_name=ntfs-3g
_pkg_name=ntfs-3g_ntfsprogs
pkg_version=2017.3.23
pkg_description="Stable read and write NTFS driver"
pkg_upstream_url="https://www.tuxera.com/community/ntfs-3g-download/"
pkg_license=('GPL2')
pkg_deps=('glibc' 'fuse' 'util-linux')
pkg_build_deps=('pkgconfig')
pkg_source=("https://www.tuxera.com/opensource/${_pkg_name}-${pkg_version}.tgz")
pkg_shasum=('d97474ae1954f772c6d2fa386a6f462c')

do_build() {
  
  ./configure --prefix=/usr \
       --with-fuse=external \
       --disable-static \
       --enable-posix-acls \
       --enable-extras \
       --disable-ldconfig \
       --mandir=/usr/share/man
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} rootlibdir=/usr/lib install
  
  ln -s /bin/ntfs-3g ${pkg_prefix}/sbin/mount.ntfs
}

