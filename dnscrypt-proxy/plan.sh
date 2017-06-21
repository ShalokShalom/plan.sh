pkg_origin=

pkg_name=dnscrypt-proxy
pkg_version=1.9.4
pkg_description="Tool for securing communications between a client and a DNS resolver"
pkg_upstream_url="https://dnscrypt.org/"
pkg_license=('custom:ISC')
pkg_deps=('libsodium')
pkg_source=("https://download.dnscrypt.org/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('448059fa937507641b4ae82b7ca8fcdf')

do_build() {
  cd ${pkg_name}-${pkg_version}
  #patch -p1 -i $CACHE_PATH/a66823e1ad8d8eb6d36a5d2e050b20765089754d.patch
  
  ./configure --prefix=/usr --with-systemd 
  make -j2
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix} install

  mkdir -p ${pkg_prefix}/{usr/share/{licenses,doc}/${pkg_name},usr/lib/systemd/system}
  install -m 644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}
  install -m 644 AUTHORS NEWS README README.markdown ${pkg_prefix}/usr/share/doc/${pkg_name}
  
  install -m 644 dnscrypt-proxy.service ${pkg_prefix}/usr/lib/systemd/system
  install -m 644 dnscrypt-proxy.socket ${pkg_prefix}/usr/lib/systemd/system
  sed -i 's|/usr/local/sbin|/usr/sbin|' ${pkg_prefix}/usr/lib/systemd/system/dnscrypt-proxy.service
}

