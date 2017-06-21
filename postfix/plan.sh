pkg_origin=cosmos

pkg_name=postfix
pkg_version=3.2.2
pkg_description='Secure, fast, easy to administer alternative to Sendmail'
pkg_upstream_url='http://www.postfix.org/'
pkg_license=('custom')
pkg_deps=('pcre' 'libsasl' 'mariadb' 'postgresql-libs' 'sqlite3' 'libldap' 'db' 'icu')
backup=('etc/postfix/'{access,aliases,canonical,generic,header_checks,main.cf,master.cf,relocated,transport,virtual})
install=$pkg_name.install
pkg_source=("ftp://ftp.porcupine.org/mirrors/postfix-release/official/${pkg_name}-${pkg_version}.tar.gz"
        'aliases.patch'
        'postfix.service')
pkg_shasum=('aea073a9b0bea5bdb590460a270a4aa0'
         '9cc2ee3c72e134c2da5a895abaa56f30'
         '24af169de13c34dac03d787c3e607ec5')

do_build() {

	make makefiles DEBUG='' CCARGS=' \
		-DUSE_SASL_AUTH -DUSE_CYRUS_SASL -I/usr/include/sasl \
		-DHAS_LDAP \
		-DUSE_TLS \
		-DHAS_MYSQL -I/usr/include/mysql \
		-DHAS_PGSQL -I/usr/include/postgresql \
		-DHAS_SQLITE \
	' AUXLIBS=' \
		-lsasl2 \
		-lldap -llber \
		-lssl -lcrypto \
		-lmysqlclient -lz -lm \
		-lpq \
		-lsqlite3 -lpthread \
	' OPT="${CFLAGS} ${LDFLAGS}"

	make
}

do_package() {

	sh postfix-install -non-interactive \
		install_root=${pkg_prefix} \
		daemon_directory=/usr/lib/${pkg_name} \
		sample_directory=/etc/${pkg_name}/sample \
		manpage_directory=/usr/share/man \
		readme_directory=/usr/share/doc/${pkg_name}

	install -Dm644 ${CACHE_PATH}/${pkg_name}.service ${pkg_prefix}/usr/lib/systemd/system/${pkg_name}.service
	install -D -m644 LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE

	patch -p0 < ${CACHE_PATH}/aliases.patch
	sed 's/^\(\$manpage[^:]*\):/\1.gz:/' -i etc/${pkg_name}/postfix-files
}
