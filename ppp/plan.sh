pkg_origin=cosmos

pkg_name=ppp
pkg_version=2.4.7
pkg_description="Daemon which implements the Point-to-Point Protocol for dial-up networking"
pkg_upstream_url="http://www.samba.org/ppp/"
pkg_license=('custom:GPL/BSD')
pkg_deps=('glibc' 'libpcap')
backup=(etc/ppp/{chap-secrets,pap-secrets,options,ip-up,ip-down})
pkg_source=("https://ftp.samba.org/pub/ppp/ppp-${pkg_version}.tar.gz"
        'options'
        'pon'
        'poff'
        'plog'
        'pon.1'
        'ip-up'
        'ip-down'
        'ip-up.d.dns.sh'
        'ip-down.d.dns.sh'
        'ipv6-up'
        'ipv6-down'
        'ipv6-up.d.iface-config.sh'
        'ppp.service'
        'fix-linux-vs-glibc-headers-compile-error-mess.patch')
pkg_shasum=('78818f40e6d33a1d1de68a1551f6595a'
         '7a9259a8f038073eeea7e4552ff1849f'
         '48c024f73a80c8b69c4def22f86902cc'
         '2d811f8470ccdea3b8c4505a438483e9'
         '86cdaf133f7a79fb464f02d83afc7734'
         '44cc662ba9aa61dd9add3ddd4c5ded57'
         'e4beb16ed600b61336d50b2bd2df7cd5'
         '2fa0671f40711e69194ccf60979f8b33'
         '4a074d74c29625b254a1db720cb87b99'
         '8d1be5af8e46393ba6eb273377831e38'
         '252d7aeed930135adbba2e9d142f6896'
         '6709475ae49b5149f67209f3835d717e'
         '6da32ca59ff9ef6ba31db47344c29300'
         'ee9604daf0056e79e80817c76d1d9627'
         '1400025c09e0084d3fd75eed8574494b')

do_build() {
  cd ${pkg_name}-${pkg_version}

  # -D_GNU_SOURCE is needed for IPv6 
  export CFLAGS="$CFLAGS -D_GNU_SOURCE"
  sed -i "s:-O2 -pipe -Wall -g:${CFLAGS}:" pppd/Makefile.linux
  sed -i "s:-g -O2:${CFLAGS}:" pppd/plugins/Makefile.linux
  sed -i "s:-O2:${CFLAGS}:" pppstats/Makefile.linux
  sed -i "s:-O2 -g -pipe:${CFLAGS}:" chat/Makefile.linux
  sed -i "s:-O:${CFLAGS}:" pppdump/Makefile.linux

  # active filter
  sed -i "s:^#FILTER=y:FILTER=y:" pppd/Makefile.linux
  # ipv6 support
  sed -i "s:^#HAVE_INET6=y:HAVE_INET6=y:" pppd/Makefile.linux
  # Microsoft proprietary Callback Control Protocol
  sed -i "s:^#CBCP=y:CBCP=y:" pppd/Makefile.linux 
  
  #fix from FW for glibc 2.25
  patch -p1 -i ${CACHE_PATH}/fix-linux-vs-glibc-headers-compile-error-mess.patch

  ./configure --prefix=/usr
  make 
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix}/usr install 
  install -D -m644 ${CACHE_PATH}/options ${pkg_prefix}/etc/ppp/options
  install -D -m755 ${CACHE_PATH}/ip-up   ${pkg_prefix}/etc/ppp/ip-up
  install -D -m755 ${CACHE_PATH}/ip-down ${pkg_prefix}/etc/ppp/ip-down
  install -d -m755 ${pkg_prefix}/etc/ppp/ip-up.d
  install -d -m755 ${pkg_prefix}/etc/ppp/ip-down.d
  install -m755 ${CACHE_PATH}/ip-up.d.dns.sh   ${pkg_prefix}/etc/ppp/ip-up.d/00-dns.sh
  install -m755 ${CACHE_PATH}/ip-down.d.dns.sh ${pkg_prefix}/etc/ppp/ip-down.d/00-dns.sh
  install -D -m755 ${CACHE_PATH}/ipv6-up   ${pkg_prefix}/etc/ppp/ipv6-up
  install -D -m755 ${CACHE_PATH}/ipv6-down ${pkg_prefix}/etc/ppp/ipv6-down
  install -d -m755 ${pkg_prefix}/etc/ppp/ipv6-up.d
  install -d -m755 ${pkg_prefix}/etc/ppp/ipv6-down.d
  install -m755 ${CACHE_PATH}/ipv6-up.d.iface-config.sh ${pkg_prefix}/etc/ppp/ipv6-up.d/00-iface-config.sh
  install -D -m755 ${CACHE_PATH}/pon  ${pkg_prefix}/usr/bin/pon
  install -D -m755 ${CACHE_PATH}/poff ${pkg_prefix}/usr/bin/poff
  install -D -m755 ${CACHE_PATH}/plog ${pkg_prefix}/usr/sbin/plog
  install -D -m600 etc.ppp/pap-secrets  ${pkg_prefix}/etc/ppp/pap-secrets
  install -D -m600 etc.ppp/chap-secrets ${pkg_prefix}/etc/ppp/chap-secrets
  install -D -m644 ${CACHE_PATH}/pon.1 ${pkg_prefix}/usr/share/man/man1/pon.1
  install -d -m755 ${pkg_prefix}/etc/ppp/peers 
  chmod 0755 ${pkg_prefix}/usr/lib/pppd/${pkg_version}/*.so
  install -D -m644 ${CACHE_PATH}/ppp.service ${pkg_prefix}/usr/lib/systemd/system/ppp@.service
}
