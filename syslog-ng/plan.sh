pkg_origin=cosmos

pkg_name=syslog-ng
pkg_version=3.9.1
pkg_description="Next-generation syslogd with advanced networking and filtering capabilities"
pkg_license=('GPL2')
pkg_upstream_url="http://www.balabit.com/network-security/syslog-ng/"
pkg_deps=('glib2' 'eventlog' 'openssl' 'libcap' 'awk' 'systemd' 'json-c')
pkg_build_deps=('flex' 'pkg-config' 'python2' 'libxslt')
optpkg_deps=('logrotate: for rotating log files')
backup=('etc/syslog-ng/scl.conf'
        'etc/syslog-ng/syslog-ng.conf'
        'etc/logrotate.d/syslog-ng')
pkg_source=("https://github.com/balabit/syslog-ng/releases/download/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
        'syslog-ng.conf'
        'syslog-ng.logrotate')
pkg_shasum=('1b48da9ef620cf06e55e481b5abb677a'
         'b7afe73b7faef3d80e76943f1f5989d3'
         '0c0d5149bd3e8d666c506351edecbe71')

do_build() {
  cd ${pkg_name}-${pkg_version}

  ./configure \
    --prefix=/usr \
    --sysconfdir=/etc/syslog-ng \
    --libexecdir=/usr/lib \
    --localstatedir=/var/lib/syslog-ng \
    --datadir=/usr/share \
    --with-pidfile-dir=/run \
    --disable-spoof-source \
    --enable-systemd \
    --enable-ipv6 \
    --with-systemdsystemunitdir=/usr/lib/systemd/system \
    --with-python=2.7 \
    --with-jsonc=system

  make -j1
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix} install

  install -dm755 ${pkg_prefix}/var/lib/syslog-ng ${pkg_prefix}/etc/syslog-ng/patterndb.d
  #install -Dm644 ${CACHE_PATH}/syslog-ng.conf ${pkg_prefix}/etc/syslog-ng/syslog-ng.conf
  install -Dm644 ${CACHE_PATH}/syslog-ng.logrotate ${pkg_prefix}/etc/logrotate.d/syslog-ng
}
