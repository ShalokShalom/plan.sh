pkg_origin=cosmos

pkg_name=traceroute
pkg_version=2.1.0
pkg_description="Tracks the route taken by packets over an IP network"
pkg_upstream_url="http://traceroute.sourceforge.net/"
pkg_license=('GPL2')
pkg_deps=('glibc')
pkg_source=("http://downloads.sourceforge.net/traceroute/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('84d329d67abc3fb83fc8cb12aeaddaba')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  make CFLAGS="$CFLAGS"
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  
  make prefix=/usr DESTDIR=${pkg_prefix} install
}
