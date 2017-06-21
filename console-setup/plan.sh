pkg_origin=cosmos
 
pkg_name=console-setup
pkg_version=1.157
pkg_description="Translate XKB layout to loadkeys or kbdcontrol format"
pkg_upstream_url="http://anonscm.debian.org/cgit/d-i/console-setup.git/"
pkg_license=('GPL2')
pkg_deps=('perl')
pkg_source=("http://ftp.de.debian.org/debian/pool/main/c/console-setup/${pkg_name}_${pkg_version}.tar.xz")
pkg_shasum=('206bd1d2d91395fa512e44737ddad399')

do_package() {
  
  install -d ${pkg_prefix}/usr/bin/
  install -m755 Keyboard/ckbcomp ${pkg_prefix}/usr/bin/
}
