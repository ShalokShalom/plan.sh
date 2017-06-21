pkg_origin=cosmos

# check tdb & ldb for updates before building
pkg_name=samba
pkg_version=4.6.5
_pkg_version=4.6.5
pkg_description="The standard Windows interoperability suite of programs for Linux and Unix."
pkg_upstream_url="https://www.samba.org"
pkg_license=('GPL3')
pkg_deps=('readline' 'popt' 'libldap' 'libcap' 'krb5' 'db' 'e2fsprogs' 'tdb' 'talloc'
         'cifs-utils' 'libcups' 'acl' 'pam' 'gamin' 'gnutls' 'libbsd' 'ldb' 'tevent'
         'libgcrypt' 'python2' 'libaio' 'iniparser' 'libarchive')
pkg_build_deps=('pkg-config' 'docbook-xsl')
backup=(etc/logrotate.d/samba
        etc/pam.d/samba
        etc/samba/smb.conf
        etc/conf.d/samba)
pkg_source=("https://us1.samba.org/samba/ftp/stable/${pkg_name}-${_pkg_version}.tar.gz"
        'samba.logrotate'
        'samba.pam'
        'samba.service'
        'smbd.service'
        'smbd.socket'
        'smbd@.service'
        'nmbd.service'
        'winbindd.service'
        'samba.conf'
        'samba.conf.d')
pkg_shasum=('2ae8ce2862d8bfa95e4681371ebb1623'
         '5697da77590ec092cc8a883bae06093c'
         '96f82c38f3f540b53f3e5144900acf17'
         'ee4763a656cf00d92bfda31b6bb2c5cb'
         '621a3c8ec9f05667c20ab4d5a04a86c9'
         'a78b9aa93eb14b0ac445897395693225'
         '70186fa43510bf99e3afd5951e814fbf'
         '90845b89f2321cb19c0b13f385f1782a'
         '64a52bc798033aeabfae3410bd559aa4'
         '49abd7b719e3713a3f75a8a50958e381'
         '6c447748a064d631435dbef0a3dcf32f')

do_build() {
  #patch -p1 -i ${CACHE_PATH}/gnutls34.patch
  # fix for forcing build with tevent 0.9.31
  #cp /usr/include/tevent_internal.h lib/tevent/
  
  _samba4_idmap_modules=idmap_ad,idmap_rid,idmap_adex,idmap_hash,idmap_tdb2
  _samba4_pdb_modules=pdb_tdbsam,pdb_ldap,pdb_ads,pdb_smbpasswd,pdb_wbc_sam,pdb_samba4
  _samba4_auth_modules=auth_unix,auth_wbc,auth_server,auth_netlogond,auth_script,auth_samba4
  
  ./configure --prefix=/usr \
              --libdir=/usr/lib/ \
              --localstatedir=/var \
              --libexecdir=/usr/lib \
              --with-configdir=/etc/samba \
              --with-lockdir=/var/cache/samba \
              --with-sockets-dir=/var/run/samba \
              --with-piddir=/var/run/ \
              --enable-fhs \
              --with-pam \
              --with-pammodulesdir=/usr/lib/security \
              --with-ads \
              --with-acl-support \
              --with-ldap \
              --with-winbind \
              --enable-gnutls \
              --disable-avahi \
              --with-shared-modules=${_samba4_idmap_modules},${_samba4_pdb_modules},${_samba4_auth_modules} \
              --disable-rpath-install
  make
}

do_package() {
  make DESTDIR=$CACHE_PATH install
  
  mkdir -p ${CACHE_PATH}/usr/lib/cups/backend
  ln -sf /usr/bin/smbspool ${CACHE_PATH}/usr/lib/cups/backend/smb
  
  install -d -m755 ${CACHE_PATH}/etc/samba
  install -m644 ${CACHE_PATH}/samba-${_pkg_version}/packaging/LSB/smb.conf ${CACHE_PATH}/etc/samba/smb.conf.default
  
  mkdir -p ${CACHE_PATH}/etc/samba/private
  chmod 700 ${CACHE_PATH}/etc/samba/private
  
  install -D -m644 ${CACHE_PATH}/samba.logrotate ${CACHE_PATH}/etc/logrotate.d/samba
  install -D -m644 ${CACHE_PATH}/samba.pam ${CACHE_PATH}/etc/pam.d/samba
  
  # spool directory
  install -d -m1777 ${CACHE_PATH}/var/spool/samba
  #sed -i 's|/usr/spool/samba|/var/spool/samba|g' ${CACHE_PATH}/etc/samba/smb.conf.default
  
  # fix logrotate
  sed -i -e 's|log.%m|%m.log|g' ${CACHE_PATH}/etc/samba/smb.conf.default
  
  # winbind krb5 locator
  mkdir -p ${CACHE_PATH}/usr/lib/krb5/plugins/libkrb5
  mv  ${CACHE_PATH}/usr/lib/winbind_krb5_locator.so ${CACHE_PATH}/usr/lib/krb5/plugins/libkrb5/
  
  # systemd files
  install -d -m755 ${CACHE_PATH}/usr/lib/systemd/system

  install -m644 ${CACHE_PATH}/*.service ${CACHE_PATH}/usr/lib/systemd/system/
  install -m644 ${CACHE_PATH}/*.socket ${CACHE_PATH}/usr/lib/systemd/system/
  install -d -m755  ${CACHE_PATH}/etc/conf.d
  install -m644 ${CACHE_PATH}/samba.conf.d ${CACHE_PATH}/etc/conf.d/samba

  # create non-persistent dirs via tmpfiles instead of shipping packaged-in
  install -D -m644 ${CACHE_PATH}/samba.conf ${CACHE_PATH}/usr/lib/tmpfiles.d/samba.conf
  
  rm -rf ${CACHE_PATH}/var/run
  
  # copy ldap example
  install -D -m644 ${CACHE_PATH}/samba-${_pkg_version}/examples/LDAP/samba.schema ${CACHE_PATH}/usr/share/doc/samba/examples/LDAP/samba.schema
 }

