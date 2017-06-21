pkg_origin=cosmos

# install polkit in chroot on any update to check for pam issues
pkg_name=libtirpc
pkg_version=1.0.1
pkg_description="Transport Independent RPC library (SunRPC replacement)"
pkg_upstream_url="http://libtirpc.sourceforge.net/"
pkg_license=('BSD')
pkg_deps=('libgssglue')
backup=('etc/netconfig')
pkg_source=("https://downloads.sourceforge.net/sourceforge/libtirpc/${pkg_name}-${pkg_version}.tar.bz2"
        'rwlock_unlocks.patch'
        'libtirpc.patch')
pkg_shasum=('36ce1c0ff80863bb0839d54aa0b94014'
         '625729308df789bffe52c305af08b0d6'
         'c2aff9af82ac17cc718b3044ccb6ad2c')

do_build() {
  cd ${pkg_name}-${pkg_version}
  # https://sourceforge.net/p/libtirpc/mailman/message/34594076/
  patch -p1 -i ${CACHE_PATH}/rwlock_unlocks.patch
  # http://seclists.org/oss-sec/2017/q2/209
  # https://github.com/guidovranken/rpcbomb/
  patch -p1 -i ${CACHE_PATH}/libtirpc.patch
  
  ./configure --prefix=/usr --sysconf=/etc
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix} install
  
  install -D -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
