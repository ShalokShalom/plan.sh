pkg_origin=cosmos

pkg_name=autofs
pkg_version=5.1.3
pkg_description='A kernel-based automounter for Linux.'
pkg_upstream_url='http://freshmeat.net/projects/autofs'
pkg_license=('GPL2')
pkg_deps=('libldap' 'libxml2' 'krb5' 'kmod')
backup=('etc/autofs/auto.master'
        'etc/autofs/auto.misc'
        'etc/autofs/auto.net'
        'etc/autofs/auto.smb'
        'etc/autofs/autofs_ldap_auth.conf'
        'etc/default/autofs')
pkg_source=("https://www.kernel.org/pub/linux/daemons/${pkg_name}/v5/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('57a6791e596b8b8ee2c4c50420881180')

do_build() {

  sed -i -e 's|/etc/auto.misc|/etc/autofs/auto.misc|' \
         -e 's|/etc/auto.master.d|/etc/autofs/auto.master.d|' samples/auto.master

  ./configure --prefix=/usr \
        --sysconfdir=/etc/autofs \
        --with-mapdir=/etc/autofs \
        --without-hesiod \
        --enable-ignore-busy \
        --with-systemd
  make
}

do_package() {
  make INSTALLROOT=${pkg_prefix} install
  
  rm -r $pkg_prefix/run
  install -dm755 ${pkg_prefix}/etc/autofs/auto.master.d
}
