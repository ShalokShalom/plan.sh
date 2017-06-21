pkg_origin=cosmos
# $Id: PKGBUILD 26538 2009-02-08 23:14:14Z eric $
# Contributor: Damir Perisa <damir.perisa@bluewin.ch>

pkg_name=lxsplit
pkg_version=0.2.4
pkg_description="Command-line file splitter/joiner compatible with any HJSplit version"
pkg_upstream_url="http://lxsplit.sourceforge.net/"
pkg_license=('GPL')
pkg_deps=('glibc')
#pkg_source=(http://www.freebyte.com/download/$pkg_name.tar.gz)
pkg_source=(http://downloads.sourceforge.net/sourceforge/lxsplit/lxsplit-${pkg_version}.tar.gz)
pkg_shasum=('ed21a08c167c08d4d81c820782947cb1')

do_build() {
  install -d ${pkg_prefix}/usr/bin
  make || return 1
  make INSTALL_PATH=${pkg_prefix}/usr/bin install || return 1
}
