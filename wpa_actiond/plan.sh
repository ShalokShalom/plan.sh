pkg_origin=cosmos

pkg_name=wpa_actiond
pkg_version=1.4
pkg_description="Daemon that connects to wpa_supplicant and handles connect and disconnect events"
pkg_upstream_url="http://projects.archlinux.org/wpa_actiond.git/"
pkg_license=('GPL')
pkg_deps=('glibc' 'wpa_supplicant')
pkg_source=("https://sources.archlinux.org/other/wpa_actiond/$pkg_name-$pkg_version.tar.xz")
pkg_shasum=('865da85b30e41555b6d3ca6b4ad4c306')

do_build() {
  cd ${pkg_name}-${pkg_version}

  make CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  
  install -D -m755 wpa_actiond ${pkg_prefix}/usr/sbin/wpa_actiond
}
