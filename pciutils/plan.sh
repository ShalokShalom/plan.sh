pkg_origin=cosmos

pkg_name=pciutils
pkg_version=3.5.4
pkg_description="PCI bus configuration space access library and tools"
pkg_license=('GPL2')
pkg_upstream_url="http://mj.ucw.cz/pciutils.html"
optpkg_deps=('sh: required by update-pciids') 
pkg_deps=('glibc' 'hwids' 'kmod')
pkg_build_deps=('wget')
pkg_source=("ftp://ftp.kernel.org/pub/software/utils/${pkg_name}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('e82537cd2194111c45fa7e684b52252e')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  ./update-pciids.sh
  
  make OPT="${CFLAGS} -fPIC -DPIC" ZLIB=no SHARED=no PREFIX=/usr SHAREDIR=/usr/share/hwdata MANDIR=/usr/share/man all
  cp lib/libpci.a ${CACHE_PATH}/
  make clean
  make OPT="${CFLAGS}" ZLIB=no SHARED=yes PREFIX=/usr SHAREDIR=/usr/share/hwdata MANDIR=/usr/share/man all
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make SHARED=yes PREFIX=/usr SHAREDIR=/usr/share/hwdata MANDIR=/usr/share/man DESTDIR=${pkg_prefix} install install-lib
  
  install -m644 ${CACHE_PATH}/libpci.a ${pkg_prefix}/usr/lib/
  # part of hwids package
  rm -rf $pkg_prefix/usr/{sbin/update-pciids,share/{man/man8/update-pciids.8.gz,hwdata}}
}
