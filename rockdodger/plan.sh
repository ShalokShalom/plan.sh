pkg_origin=cosmos
# $Id: PKGBUILD 78008 2010-04-19 08:16:13Z dgriffiths $
# Maintainer: dale <dale@archlinux.org>
# Contributor: Tom Newsom <Jeepster@gmx.co.uk>

pkg_name=rockdodger
pkg_version=0.6
pkg_description="Space Rocks is a game - Dodge the space rocks, use your shields, fire your thrusters, cross your fingers, and kiss your ship goodbye"
pkg_upstream_url="http://spacerocks.sourceforge.net/"
pkg_license=('GPL')
pkg_deps=('sdl' 'sdl_mixer' 'sdl_image')
install=rockdodger.install
pkg_source=(http://downloads.sourceforge.net/spacerocks/${pkg_name}-${pkg_version}.tar.gz rockdodger-0.6.0a-gcc41.patch)
pkg_shasum=('a82a564a6530e60e7f041f7d95c4cae8' 'c8b17a6ffaa12f1a116170437b4629c0')

do_build() {
 patch -Np0 -i ../rockdodger-0.6.0a-gcc41.patch || return 1
 sed -i 's|/usr/share/rockdodger/.highscore|/var/games/rockdodger.highscore|' main.c || return 1
 sed -i "s|\./data|/usr/share/rockdodger/data|" main.c || return 1
 sed -i -e "s:-g:${CFLAGS}:" Makefile || return 1
 make || return 1

 install -D -m755 rockdodger ${CACHE_PATH}/usr/bin/rockdodger
 install -d ${CACHE_PATH}/usr/share/rockdodger/data
 install -m644 data/*.{bmp,png,wav,mod} ${CACHE_PATH}/usr/share/rockdodger/data

 chown root:games ${CACHE_PATH}/usr/bin/rockdodger
 chmod 2755 ${CACHE_PATH}/usr/bin/rockdodger
 install -d ${CACHE_PATH}/var/games
 chown root:games ${CACHE_PATH}/var/games
 chmod 775 ${CACHE_PATH}/var/games
}
