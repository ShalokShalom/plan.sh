pkg_origin=cosmos
# $Id: PKGBUILD 36862 2009-04-28 06:07:16Z eric $
# Contributor: Dale Blount <dale@archlinux.org>
# Maintainer: Dale Blount <dale@archlinux.org>
pkg_name=rbldnsd
pkg_version=0.996b
pkg_description="Small and fast DNS daemon which is especially made to serve DNSBL zones"
pkg_upstream_url="http://www.corpit.ru/mjt/rbldnsd.html"
pkg_license=('GPL')
pkg_deps=('zlib')
backup=('etc/conf.d/rbldnsd')
install=$pkg_name.install
pkg_source=(http://www.corpit.ru/mjt/$pkg_name/${pkg_name}_${pkg_version}.tar.gz rc.rbldnsd conf.rbldnsd)
pkg_shasum=('9a0f26f3b33764c325a96bd4c61b26fa' '1d197df99197244290217288b1a91c38'\
         '8fc8131d235a938a1e8024ab85dc93ea')

do_build() {
	./configure || return 1
	make || return 1

	install -d $CACHE_PATH/var/lib/rbldns/logs
	chown 59:59 $startdir/pkg/var/lib/rbldns || return 1
	chown 58:58 $startdir/pkg/var/lib/rbldns/logs || return 1
	chmod 0711 -R $startdir/pkg/var/lib/rbldns

	install -D -m 0755 rbldnsd $CACHE_PATH/usr/bin/rbldnsd || return 1
	install -D -m 0644 rbldnsd.8 $CACHE_PATH/usr/share/man/man8/rbldnsd.8 || return 1
	install -D -m 0644 $CACHE_PATH/conf.rbldnsd $CACHE_PATH/etc/conf.d/rbldnsd || return 1
	install -D -m 0755 $CACHE_PATH/rc.rbldnsd $CACHE_PATH/etc/rc.d/rbldnsd || return 1
}
