pkg_origin=cosmos

pkg_name=freetds
pkg_version=1.00.44
pkg_description='Library for accessing Sybase and MS SQL Server databases'
pkg_upstream_url='http://www.freetds.org'
pkg_license=('LGPL')
pkg_deps=('unixodbc' 'openssl')
backup=('etc/freetds/freetds.conf'
        'etc/freetds/locales.conf'
        'etc/freetds/pool.conf')
pkg_source=("ftp://ftp.freetds.org/pub/freetds/stable/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('a41183db026a2ea76fc45d9bb8b79e48')

do_build() {
	
	./configure --prefix=/usr \
	      --sysconfdir=/etc/freetds \
	      --mandir=/usr/share/man \
	      --enable-msdblib \
	      --with-tdsver=7.0 \
	      --with-openssl \
	      --with-unixodbc=/usr
	make
}

do_package() {
	make DESTDIR=${pkg_prefix} install
	
	install -m644 samples/unixodbc.freetds.driver.template ${pkg_prefix}/etc/${pkg_name}/
	install -m644 samples/unixodbc.jdbc.datasource.template ${pkg_prefix}/etc/${pkg_name}/
	install -m644 samples/odbc.ini ${pkg_prefix}/etc/${pkg_name}/odbc.ini.template
}
