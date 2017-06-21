pkg_origin=cosmos

pkg_name=s-nail
pkg_version=14.8.16
pkg_description="Mail processing system and commandline utility for sending email"
pkg_upstream_url="https://www.sdaoden.eu/code.html#s-naill"
pkg_license=('BSD')
pkg_deps=('openssl' 'krb5')
optpkg_deps=('postfix: for sending mail')
backup=('etc/mail.rc')
pkg_source=("https://www.sdaoden.eu/downloads/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('ed43ea92b7586baf0dc681f68d2ff0f4')

do_build() {
  cd ${pkg_name}-${pkg_version}

  make PREFIX=/usr \
       SYSCONFDIR=/etc \
       MAILSPOOL=/var/spool/mail \
       MANDIR=/usr/share/man \
       SID= NAIL=mail \
       WANT_AUTOCC=0 \
       LIBEXECDIR=/usr/lib \
       config

  make build
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix} packager-install

  # For compatibility with the old mailx program
  ln -sf mail ${pkg_prefix}/usr/bin/mailx
  ln -sf mail ${pkg_prefix}/usr/bin/nail
  ln -sf mail.1.gz ${pkg_prefix}/usr/share/man/man1/mailx.1.gz

  install -D -m0644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
