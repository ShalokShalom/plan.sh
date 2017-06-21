pkg_origin=cosmos

pkg_name=reiserfsprogs
pkg_version=3.6.25
pkg_description="Reiserfs utilities"
pkg_upstream_url="http://www.kernel.org/pub/linux/utils/fs/reiserfs/README"
pkg_license=('GPL')
pkg_deps=('util-linux')
pkg_source=("http://ftp.kernel.org/pub/linux/kernel/people/jeffm/reiserfsprogs/v${pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('027a598b055dccb8da3aea1378a19f3c')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  ./configure --prefix=/usr --sbindir=/sbin
  make
}

do_check() {
  cd ${pkg_name}-${pkg_version}
  
  make check
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  
  make DESTDIR=${pkg_prefix} install
}
