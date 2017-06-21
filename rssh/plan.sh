pkg_origin=cosmos
# $Id: PKGBUILD 57421 2009-10-31 14:48:15Z allan $
# Maintainer: Judd Vinet <jvinet@zeroflux.org>
pkg_name=rssh
pkg_version=2.3.2
pkg_description="A restricted shell for use with OpenSSH, allowing only scp and/or sftp"
pkg_upstream_url="http://www.pizzashack.org/rssh/index.shtml"
pkg_deps=('openssh' 'glibc')
backup=('etc/rssh.conf')
pkg_license=('custom:rssh')
pkg_source=(http://downloads.sourceforge.net/sourceforge/rssh/rssh-$pkg_version.tar.gz
        rssh.patch)
pkg_shasum=('65712f2c06ff5fc6fc783bc8c2e4e1ba' '7b8c260ce1952afe6ebaf9972bf78341')

do_build() {
  patch -Np1 -i $CACHE_PATH/rssh.patch || return 1
  ./configure --prefix=/usr --libexecdir=/usr/lib/rssh \
    --mandir=/usr/share/man --sysconfdir=/etc
  make || return 1
  make DESTDIR=$CACHE_PATH install
  # install license
  install -Dm644 LICENSE $CACHE_PATH/usr/share/licenses/rssh/LICENSE
}
