pkg_origin=cosmos

pkg_name=spamassassin
pkg_version=3.3.2
pkg_description="A mail filter to identify spam."
pkg_license=('APACHE')
pkg_upstream_url="http://spamassassin.apache.org"
pkg_deps=('perl>=5.14.2' 'perl-net-dns' 'perl-uri' 'perl-html-parser' \
		'perl-digest-sha1' 'perl-io-socket-ssl' 'openssl' \
		'perl-libwww' 'perl-io-zlib' 'perl-mail-spf' 'perl-mail-dkim' \
		'perl-archive-tar' 'perl-io-socket-inet6' 'zlib' 're2c')
pkg_build_deps=('razor' 'perl-dbi') 
optpkg_deps=('razor: to identify collaborately-flagged spam')
backup=('etc/mail/spamassassin/local.cf'
        'etc/mail/spamassassin/init.pre'
        'etc/mail/spamassassin/v310.pre'
        'etc/mail/spamassassin/v312.pre'
        'etc/mail/spamassassin/v320.pre'
        'etc/mail/spamassassin/v330.pre')
install="${pkg_name}.install"
pkg_source=("http://mirrors.devlib.org/apache/${pkg_name}/source/Mail-SpamAssassin-${pkg_version}.tar.gz"
        'spamd.conf.d' 'spamassassin.service')

pkg_shasum=('d1d62cc5c6eac57e88c4006d9633b81e'
         'af501c6b0bb937a2775b747cc4b6d150'
         'ded3e012a4d502df001f2d97c495cc4e')

do_build() {

  # install module in vendor directories.
  PERL_MM_USE_DEFAULT=1 perl Makefile.PL INSTALLDIRS=vendor \
      CONTACT_ADDRESS=root@localhost ENABLE_SSL=yes PERL_TAINT=no
  make
}

do_check() {

  # SSLv2 is disabled by upstream so this test would fail
  rm -rf t/spamd_ssl_v2.t

  # parallel tests cause lots of failures; disable for now
  #export HARNESS_OPTIONS="j$(echo $MAKEFLAGS | sed 's/.*-j\([0-9][0-9]*\).*/\1/')"

  make test
}

do_package() {
  make DESTDIR="${CACHE_PATH}" install

  install -D -m644 "${CACHE_PATH}/spamd.conf.d" "${CACHE_PATH}/etc/conf.d/spamd"
  install -D -m644 "${CACHE_PATH}/spamassassin.service" "${CACHE_PATH}/usr/lib/systemd/system/spamassassin.service"
}
