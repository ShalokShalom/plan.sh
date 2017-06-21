pkg_origin=cosmos

pkg_name=virtuoso
pkg_version=6.1.8
pkg_description='A scalable cross-platform server that combines SQL/RDF/XML Data Management with Web Application Server and Web Services Platform functionality'
pkg_upstream_url='http://virtuoso.openlinksw.com/wiki/main/Main/'
pkg_license=('GPL')
pkg_deps=('libldap')
pkg_build_deps=('bison' 'flex' 'gperf' 'gawk' 'm4' 'openssl' 'zlib' 'python2' 'net-tools')
pkg_source=("http://downloads.sourceforge.net/${pkg_name}/${pkg_name}-opensource-${pkg_version}.tar.gz")
pkg_shasum=('94ef4f93cad915f73bee547fe95db725')

do_build() {

  ./configure --with-layout=debian \
    --program-transform-name='s/isql$$/isql-vt/;s/isqlw/isqlw-vt/' \
    --with-readline 
  make
}

do_package() {
  # install server
  make DESTDIR=${CACHE_PATH} install

  # install driver
  make DESTDIR=${CACHE_PATH} install

  # Install some useful tools; rename to avoid conflicts
  for bin in isql isqlw; do
    install -Dm755 ${CACHE_PATH}/virtuoso-opensource-${pkg_version}/binsrc/tests/$bin \
      ${CACHE_PATH}/usr/bin/$bin-vt
  done
}
