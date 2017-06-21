pkg_origin=cosmos

pkg_name=wireless_tools
pkg_version=29.9
_pkg_version=30
pkg_description="Wireless Tools"
pkg_upstream_url="https://hewlettpackard.github.io/wireless-tools/Tools.html"
pkg_license=('GPL')
pkg_deps=('glibc')
pkg_source=("https://hewlettpackard.github.io/wireless-tools/wireless_tools.30.pre9.tar.gz")
pkg_shasum=('ca91ba7c7eff9bfff6926b1a34a4697d')

do_build() {
  cd ${pkg_name}.${_pkg_version}
  sed '/BUILD_STATIC =/d' -i Makefile

  make
}

do_package() {
  cd ${pkg_name}.${_pkg_version}
  
  make INSTALL_DIR="${pkg_prefix}/usr/sbin" \
    INSTALL_LIB="${pkg_prefix}/usr/lib" \
    INSTALL_INC="${pkg_prefix}/usr/include" \
    INSTALL_MAN="${pkg_prefix}/usr/share/man" \
  install
}
