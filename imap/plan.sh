pkg_origin=cosmos

pkg_name=imap
pkg_version=2007f
pkg_description="An IMAP/POP server"
pkg_license=('APACHE')
pkg_upstream_url="https://www.washington.edu/imap"
pkg_deps=('openssl' 'pam')
pkg_source=("http://ftp.ntua.gr/pub/net/mail/imap/${pkg_name}-${pkg_version}.tar.gz"
        'imap'
        'ipop2'
        'ipop3')
backup=(etc/xinetd.d/{imap,ipop2,ipop3} etc/ssl/certs/{imapd,ipop3d}.pem)
pkg_shasum=('2126fd125ea26b73b20f01fcd5940369'
         'e77dedb80c2fec9bf2ef784ed5f976fb'
         'cc3eba6453242aa0b1bc8881160b2136'
         '0a5e27183a9b7e8ec5f6703125371e0a')

do_build() {
  # fix Makefile
  sed \
    -e "s:-g -fno-omit-frame-pointer -O6:\${CFLAGS}:" \
    -e "s:SSLDIR=/usr/local/ssl:SSLDIR=/usr:" \
    -e "s:SSLCERTS=\$(SSLDIR)/certs:SSLCERTS=/etc/ssl/certs:" \
    -i ${CACHE_PATH}/${pkg_name}-${pkg_version}/src/osdep/unix/Makefile
	

  make lnp SPECIALAUTHENTICATORS=ssl SSLTYPE=unix EXTRACFLAGS="${CFLAGS} -fPIC"

  # create ssl certs for secure imap
  for i in imapd ipop3d; do
    PEM1=${CACHE_PATH}/pem1
    PEM2=${CACHE_PATH}/pem2
    /usr/bin/openssl req -newkey rsa:1024 -keyout ${PEM1} \
      -nodes -x509 -days 365 -out  ${PEM2} << EOF
--
SomeState
SomeCity
SomeOrganization
SomeOrganizationalUnit
localhost.localdomain
root@localhost.localdomain
EOF

    cat ${PEM1} >  ${i}.pem
    echo ""    >> ${i}.pem
    cat ${PEM2} >> ${i}.pem
    rm ${PEM1} ${PEM2}
    umask 022
  done
}

do_package() {

  install -d ${pkg_prefix}/usr/sbin
  install -D -m0755 imapd/imapd ${pkg_prefix}/usr/sbin/imapd
  install -D -m0755 ipopd/ipop2d ${pkg_prefix}/usr/sbin/ipop2d
  install -D -m0755 ipopd/ipop3d ${pkg_prefix}/usr/sbin/ipop3d
  for i in c-client mail imap4r1 rfc822 linkage misc smtp nntp \
    osdep env_unix env fs ftl nl tcp sslio utf8 utf8aux; do
    install -D -m0644 c-client/${i}.h ${pkg_prefix}/usr/include/imap/${i}.h
  done
  install -D -m0644 c-client/c-client.a ${pkg_prefix}/usr/lib/c-client.a
  ln -sf c-client.a ${pkg_prefix}/usr/lib/libc-client.a

  install -D -m0600 imapd.pem ${pkg_prefix}/etc/ssl/certs/imapd.pem
  install -D -m0600 ipop3d.pem ${pkg_prefix}/etc/ssl/certs/ipop3d.pem

  install -D -m0644 ../imap ${pkg_prefix}/etc/xinetd.d/imap
  install -D -m0644 ../ipop2 ${pkg_prefix}/etc/xinetd.d/ipop2
  install -D -m0644 ../ipop3 ${pkg_prefix}/etc/xinetd.d/ipop3
}
