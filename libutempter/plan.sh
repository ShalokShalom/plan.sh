pkg_origin=cosmos

pkg_name=libutempter
pkg_version=1.1.6
pkg_description="Library that allows non-privileged apps to write utmp (login) info, which need root access"
pkg_upstream_url="ftp://ftp.altlinux.org/pub/people/ldv/utempter"
pkg_license=('LGPL')
pkg_deps=('glibc')
pkg_source=("ftp://ftp.altlinux.org/pub/people/ldv/utempter/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('b43827806923903aba2bc7cd3a2d45b7')

do_build() {
  RPM_OPT_FLAGS="$CFLAGS" make
  
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  chown root:utmp ${pkg_prefix}/usr/lib/utempter/utempter
  chmod 2755 ${pkg_prefix}/usr/lib/utempter/utempter
}
