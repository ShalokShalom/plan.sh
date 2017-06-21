pkg_origin=cosmos

pkg_name=libsasl
pkg_version=2.1.26
pkg_description="Cyrus Simple Authentication Service Layer (SASL) library"
pkg_upstream_url="http://cyrusimap.web.cmu.edu/downloads.html#sasl"
pkg_license=('custom')
pkg_deps=('db>=4.8' 'openssl')
pkg_source=("ftp://ftp.cyrusimap.org/cyrus-sasl/cyrus-sasl-${pkg_version}.tar.gz"
	'cyrus-sasl-2.1.19-checkpw.c.patch'
	'cyrus-sasl-db.patch'
	'cyrus-sasl-2.1.26-size_t.patch')
pkg_shasum=('a7f4e5e559a0e37b3ffc438c9456e425'
         'e27ddff076342e7a3041c4759817d04b'
         '0658201497aad359c0d66b0ab8032859'
         'f45aa8c42b32e0569ab3d14a83485b37')

do_build() {
  cd "${CACHE_PATH}/cyrus-sasl-${pkg_version}"
  #patch -p0 -i ${CACHE_PATH}/cyrus-sasl-2.1.19-checkpw.c.patch
  #patch -p1 -i ${CACHE_PATH}/cyrus-sasl-db.patch
  patch -p1 -i "${CACHE_PATH}/cyrus-sasl-2.1.26-size_t.patch"
  
  ./configure --prefix=/usr \
  	--sysconfdir=/etc \
  	--localstatedir=/var \
	--disable-anon \
	--disable-cram \
	--disable-digest \
	--disable-gssapi \
	--enable-login \
	--disable-otp \
	--enable-plain \
        --mandir=/usr/share/man
  for dir in include lib sasldb plugins utils; do
    pushd ${dir}
    make
    popd
  done
}

do_package() {
  cd "${CACHE_PATH}/cyrus-sasl-${pkg_version}"
  for dir in include lib sasldb plugins utils; do
    pushd ${dir} 
    make DESTDIR="${pkg_prefix}" install
    popd
  done

  # install license
  install -D -m644 COPYING "${pkg_prefix}/usr/share/licenses/${pkg_name}/COPYING"
}
