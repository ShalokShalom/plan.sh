pkg_origin=cosmos

# KEEP LIBTOOL FILES!
pkg_name=neon
pkg_version=0.30.2
pkg_description="HTTP and WebDAV client library with a C interface"
pkg_upstream_url="http://www.webdav.org/neon/"
pkg_license=('GPL' 'LGPL')
pkg_deps=('krb5' 'expat' 'ca-certificates')
pkg_source=("http://www.webdav.org/neon/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('e28d77bf14032d7f5046b3930704ef41')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  ./configure --prefix=/usr \
    --with-expat \
    --enable-shared \
    --disable-static \
    --with-ssl=openssl \
    --with-ca-bundle=/etc/ssl/certs/ca-certificates.crt
  make 
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  
  make DESTDIR=${pkg_prefix} install
}
