pkg_origin=cosmos

pkg_name=libnl
pkg_version=3.3.0
_pkg_version=3_3_0
pkg_description="Library for applications dealing with netlink sockets"
pkg_upstream_url="http://www.infradead.org/~tgr/libnl/"
pkg_license=('GPL')
pkg_deps=('glibc')
backup=('etc/libnl/classid' 'etc/libnl/pktloc')
pkg_source=("https://github.com/thom311/libnl/releases/download/libnl${_pkg_version}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('ab3ef137cad95bdda5ff0ffa5175dfa5')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  ./configure \
    --prefix=/usr \
    --sysconfdir=/etc \
    --sbindir=/usr/bin \
    --disable-static
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  
  make DESTDIR=${pkg_prefix} install
}

