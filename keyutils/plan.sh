pkg_origin=cosmos

pkg_name=keyutils
pkg_version=1.5.10
pkg_description="Linux Key Management Utilities"
pkg_upstream_url="http://www.kernel.org"
pkg_license=('GPL2' 'LGPL2.1')
pkg_deps=('glibc' 'sh')
backup=('etc/request-key.conf')
pkg_source=("http://people.redhat.com/~dhowells/keyutils/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('3771676319bc7b84b1549b5c63ff5243')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  make # CFLAGS=${CFLAGS} LDFLAGS=${LDFLAGS}
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  
  make DESTDIR=${pkg_prefix} LIBDIR="/usr/lib" USRLIBDIR="/usr/lib"  install
}
