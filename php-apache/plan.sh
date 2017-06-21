pkg_origin=cosmos

pkg_name=php-apache
_pkg_name=php
pkg_version=7.0.20
pkg_description='Apache SAPI for PHP'
pkg_license=('PHP')
pkg_upstream_url='http://www.php.net'
pkg_deps=("php>=${pkg_version}" 'apache') 
pkg_build_deps=('imap' 'mariadb' 'postfix' 'libzip' 'file' 'libjpeg-turbo' 'openssl' 'db' 'gmp')
backup=('etc/httpd/conf/extra/php5_module.conf')
pkg_source=("http://www.php.net/distributions/${_pkg_name}-${pkg_version}.tar.bz2"
        'apache.conf')
pkg_shasum=('d742b313c9dfea6fa6bfbb831b4240f8'
         '0677a10d2e721472d6fccb470356b322')

prepare() {
	
	sed '/APACHE_THREADED_MPM=/d' -i sapi/apache2handler/config.m4 -i configure
	sed -i -e 's|#include "buffio.h"|#include "tidybuffio.h"|' ext/tidy/tidy.c
}

do_build() {
	
	./configure --config-cache \
		--prefix=/usr \
		--sysconfdir=/etc/php \
		--localstatedir=/var \
		--with-layout=GNU \
		--with-config-file-path=/etc/php \
		--with-config-file-scan-dir=/etc/php/conf.d \
		--disable-rpath \
		--mandir=/usr/share/man \
		--without-pear \
		--enable-zend-signals \
		--enable-bcmath=shared \
		--enable-calendar=shared \
		--enable-dba=shared \
		--enable-exif=shared \
		--enable-ftp=shared \
		--enable-gd-native-ttf \
		--enable-intl=shared \
		--enable-mbstring \
		--enable-shmop=shared \
		--enable-soap=shared \
		--enable-sockets=shared \
		--enable-sysvmsg=shared \
		--enable-sysvsem=shared \
		--enable-sysvshm=shared \
		--enable-zip=shared \
		--with-bz2=shared \
		--with-cpkg_upstream_url=shared \
		--with-db4=/usr \
		--with-enchant=shared,/usr \
		--with-fpm-systemd \
		--with-freetype-dir=/usr \
		--with-xpm-dir=/usr \
		--with-gd=shared \
		--with-gdbm \
		--with-gettext=shared \
		--with-gmp=shared \
		--with-iconv=shared \
		--with-icu-dir=/usr \
		--with-imap-ssl \
		--with-imap=shared \
		--with-kerberos=/usr \
		--with-jpeg-dir=/usr \
		--with-ldap=shared \
		--with-ldap-sasl \
		--with-libzip \
		--with-mcrypt=shared \
		--with-mhash \
		--with-mysql-sock=/run/mysqld/mysqld.sock \
		--with-mysqli=shared,mysqlnd \
		--with-openssl \
		--with-pcre-regex=/usr \
		--with-pdo-dblib=shared,/usr \
		--with-pdo-mysql=shared,mysqlnd \
		--with-pdo-odbc=shared,unixODBC,/usr \
		--with-pdo-pgsql=shared \
		--with-pdo-sqlite=shared,/usr \
		--with-pgsql=shared \
		--with-png-dir=/usr \
		--with-pspell=shared \
		--with-snmp=shared \
		--with-sqlite3=shared,/usr \
		--with-tidy=shared \
		--with-unixODBC=shared,/usr \
		--with-xmlrpc=shared \
		--with-xsl=shared \
		--with-readline \
		--with-zlib \
		--with-apxs2 

	make
}
	
do_package() {
	install -D -m755 ${CACHE_PATH}/${_pkg_name}-${pkg_version}/libs/libphp7.so ${pkg_prefix}/usr/lib/httpd/modules/libphp7.so
	install -D -m644 ${CACHE_PATH}/apache.conf ${pkg_prefix}/etc/httpd/conf/extra/php7_module.conf
}
