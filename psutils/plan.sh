pkg_origin=cosmos

pkg_name=psutils
pkg_version=1.17
_pkg_version=p17
pkg_description="A set of postscript utilities"
pkg_upstream_url="http://knackered.org/angus/psutils/"
pkg_license=('custom')
pkg_deps=('glibc' 'ghostscript')
pkg_source=("ftp://ftp.knackered.org/pub/psutils/${pkg_name}-${_pkg_version}.tar.gz"
        'psutils-1.17.diff')
pkg_shasum=('b161522f3bd1507655326afa7db4a0ad'
         '2b49e9e796000b42f42804d4b50a2be1')

do_build() {
  patch -p1 -i ${CACHE_PATH}/psutils-1.17.diff 
  
  make -f Makefile.unix BINDIR=/usr/bin \
    INCLUDEDIR=/usr/include/psutils PERL=/usr/bin/perl \
    MANDIR=/usr/share/man/man1 
}

do_package() {
  
  install -d -m755 ${CACHE_PATH}/usr/include
  install -d -m755 ${CACHE_PATH}/usr/share/man
  
  make -f Makefile.unix BINDIR=${CACHE_PATH}/usr/bin \
    INCLUDEDIR=${CACHE_PATH}/usr/include/psutils PERL=/usr/bin/perl \
    MANDIR=${CACHE_PATH}/usr/share/man/man1 install 
    
  install -m755 -d ${CACHE_PATH}/usr/share/licenses/${pkg_name}
  install -m644 LICENSE ${CACHE_PATH}/usr/share/licenses/${pkg_name}/ 
}
