pkg_origin=cosmos

pkg_name=cyrus-sasl-plugins
pkg_version=2.1.26
pkg_description="Cyrus Simple Authentication Service Layer (SASL) library"
pkg_upstream_url="http://cyrusimap.web.cmu.edu/"
pkg_license=('custom')
pkg_deps=('postgresql-libs>=8.4.1' 'krb5' 'libldap>2.4' 'libmariadbclient')
pkg_source=("ftp://ftp.cyrusimap.org/cyrus-sasl/cyrus-sasl-${pkg_version}.tar.gz"
        'cyrus-sasl-2.1.22-gcc44.patch'
        'db5_support.patch')
pkg_shasum=('a7f4e5e559a0e37b3ffc438c9456e425'
         '5deb4d67b53ecba20c7887fc8fdebee1'
         'd86a5aa2e3b5b7c1bad6f8b548b7ea36')

do_build() {
  #patch -p1 -i $CACHE_PATH/cyrus-sasl-2.1.22-gcc44.patch 
  #patch -p1 -i "${CACHE_PATH}/db5_support.patch"

  ./configure --prefix=/usr \
    --sysconfdir=/etc \
    --localstatedir=/var \
    --disable-login \
    --disable-plain \
    --enable-sql \
    --disable-sqlite \
    --enable-gssapi=/usr/include/gssapi \
    --with-mysql=/usr \
    --with-pgsql=/usr \
    --enable-postgresql \
    --enable-ldapdb \
    --with-ldap=/usr
  make
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install 
  
  install -Dm644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/COPYING

  rm -f ${pkg_prefix}/usr/lib/sasl2/libsasldb.*
  rm -f ${pkg_prefix}/usr/lib/libsasl2.*
  rm -f ${pkg_prefix}/usr/lib/sasl2/libscram.*
  rm -rf ${pkg_prefix}/usr/include/sasl
  rm -rf ${pkg_prefix}/usr/sbin
  rm -rf ${pkg_prefix}/usr/share/man/man8
}
