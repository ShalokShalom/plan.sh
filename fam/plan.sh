pkg_origin=cosmos
# $Id: PKGBUILD 42582 2009-06-16 05:21:39Z tpowa $
# Maintainer: Allan McRae <allan@archlinux.org>
# Contributor: Tom Newsom <Jeepster@gmx.co.uk>

pkg_name=fam
pkg_version=2.7.0
pkg_description="File Alteration Monitor"
pkg_license=('LGPL' 'GPL')
pkg_deps=('rpcbind' 'gcc-libs' 'bash')
pkg_upstream_url="http://oss.sgi.com/projects/fam/"
backup=(etc/fam/fam.conf)
pkg_source=(ftp://oss.sgi.com/projects/fam/download/stable/${pkg_name}-${pkg_version}.tar.gz
	fam-2.7.0-dnotify.patch
	fam-2.7.0-largefiles.patch
	fam-2.7.0-limits.patch
	fam-2.7.0-buildfixes.patch
	fam)
pkg_shasum=('1bf3ae6c0c58d3201afc97c6a4834e39'
         '073d1763318344635ea316293390205c'
         '47b41e0b0498793af004696a096d7da1'
         '2638b8ffacb9f03b6e438e08ea7b290a'
         'fc0cabc0ac4f819680401eb3090c29c9'
         '0b4dd9894ccc03f57787f9dfc0a7bd6f')

do_build() {
  patch -Np1 -i ${CACHE_PATH}/fam-2.7.0-dnotify.patch || return 1
  patch -Np1 -i ${CACHE_PATH}/fam-2.7.0-largefiles.patch || return 1
  patch -Np0 -i ${CACHE_PATH}/fam-2.7.0-limits.patch || return 1
  patch -Np1 -i ${CACHE_PATH}/fam-2.7.0-buildfixes.patch || return 1

  chmod 755 configure || return 1

  autoheader || return 1
  aclocal || return 1
  automake -a -c || return 1
  autoconf || return 1
  libtoolize --copy --force || return 1

  ./configure --prefix=/usr --sysconfdir=/etc/fam
  make || return 1
  make DESTDIR=${pkg_prefix} install
  install -D -m755 ../fam ${pkg_prefix}/etc/rc.d/fam
}
