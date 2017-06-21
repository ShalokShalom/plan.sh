pkg_origin=cosmos
 
pkgbase="foomatic"
pkg_name=('foomatic-db' 'foomatic-db-engine' 'foomatic-db-nonfree')
_snapdate=20170331
_relver=4.0
pkg_version=${_relver}_${_snapdate}
pkg_build_deps=('cups' 'perl' 'libxml2' 'enscript' 'perl' 'net-snmp' 'bash')
pkg_source=("http://www.openprinting.org/download/foomatic/${pkgbase}-db-engine-${_relver}-${_snapdate}.tar.gz"
        "http://www.openprinting.org/download/foomatic/${pkgbase}-db-${_relver}-${_snapdate}.tar.gz"
        "http://www.openprinting.org/download/foomatic/${pkgbase}-db-nonfree-${_snapdate}.tar.gz")
pkg_upstream_url="http://www.linuxprinting.org/foomatic.html"
pkg_shasum=('f92d88edf679b66177045e4e7bc20c85'
         '9a0391db2efa7e9df591eb29c6a7c1d9'
         'bcd2aa0b803ae10c89ddc4b7c031610a') 

package_foomatic-db() {

  pkg_description="Foomatic - The collected knowledge about printers, drivers, and driver options in XML files, used by foomatic-db-engine to generate PPD files."
  arch=('x86_64')
  pkg_license=('GPL' 'custom')
  pkg_deps=('perl' 'libxml2')

  ./configure --prefix=/usr
  make DESTDIR=${pkg_prefix} install 
  install -v -Dm0644 ${CACHE_PATH}/${pkg_name}-${_snapdate}/COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/COPYING
}

package_foomatic-db-engine() {

  pkg_description="Foomatic - Foomatic's database engine generates PPD files from the data in Foomatic's XML database. It also contains scripts to directly generate print queues and handle jobs."
  arch=('x86_64')
  pkg_license=('GPL')
  pkg_deps=('perl' 'libxml2' 'cups-filters' 'bash')

  ./configure --prefix=/usr
  make 
  eval `perl -V:archname`
  make DESTDIR=${pkg_prefix} \
       INSTALLARCHLIB=/usr/lib/perl5/vendor_perl/ \
       INSTALLSITELIB=/usr/lib/perl5/vendor_perl/ \
       INSTALLSITEARCH=/usr/lib/perl5/vendor_perl/ install 
  /usr/bin/find ${pkg_prefix} -name '.packlist' -delete
  # fix permissions
  chmod 755 ${pkg_prefix}/usr/lib{,/perl5,/perl5/vendor_perl}
}

package_foomatic-db-nonfree() {

  pkg_description="Foomatic - database extension consisting of manufacturer-supplied PPD files released under non-free licenses"
  arch=('x86_64')
  pkg_license=('custom')
  pkg_deps=('perl' 'libxml2' "foomatic-db-engine" 'foomatic-db')

  ./configure --prefix=/usr
  make DESTDIR=${pkg_prefix} install 
  install -Dm644 COPYING ${pkg_prefix}/usr/share/licenses/foomatic-db-nonfree/COPYING
}
