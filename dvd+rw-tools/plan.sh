pkg_origin=cosmos

pkg_name=dvd+rw-tools
pkg_version=7.1
pkg_description="dvd burning tools"
pkg_license=('GPL')
pkg_upstream_url="http://fy.chalmers.se/~appro/linux/DVD+RW"
pkg_deps=('cdrtools' 'gcc-libs')
pkg_source=("http://fy.chalmers.se/~appro/linux/DVD+RW/tools/${pkg_name}-${pkg_version}.tar.gz"
        'dvd+rw-tools-7.0-dvddl.patch'
        'dvd+rw-tools-7.0-glibc2.6.90.patch'
        'dvd+rw-tools-7.0-wctomb.patch'
        'dvd+rw-tools-7.0-wexit.patch')
pkg_shasum=('8acb3c885c87f6838704a0025e435871'
         '65d30aa98ff314f256d0a1afb9e3edf6'
         '1be5401035ca850edb7e522f22aead4b'
         '3ba1af063b30f942e1cd2004044702d3'
         'b2c66b6c6243b207fbe4f6ae34fa6cba')

do_build() {
  patch -p0 -i ${CACHE_PATH}/dvd+rw-tools-7.0-dvddl.patch
  patch -p1 -i ${CACHE_PATH}/dvd+rw-tools-7.0-glibc2.6.90.patch
  patch -p0 -i ${CACHE_PATH}/dvd+rw-tools-7.0-wctomb.patch
  patch -p1 -i ${CACHE_PATH}/dvd+rw-tools-7.0-wexit.patch

  make
}

do_package() {
  install -m755 -d ${pkg_prefix}/usr/bin
  install -m755 -d ${pkg_prefix}/usr/share/man/man1

  install -m755 growisofs dvd+rw-booktype dvd+rw-format dvd+rw-mediainfo dvd-ram-control ${pkg_prefix}/usr/bin/
  install -m644 growisofs.1 ${pkg_prefix}/usr/share/man/man1/growisofs.1
}
