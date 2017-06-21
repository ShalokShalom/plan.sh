pkg_origin=cosmos

pkg_name=kmod
pkg_version=24
#_kver=4.0.5-1
pkg_description="Linux kernel module handling"
pkg_upstream_url='http://git.kernel.org/?p=utils/kernel/kmod/kmod.git;a=summary'
pkg_license=('GPL2')
pkg_deps=('glibc' 'zlib')
pkg_source=("ftp://ftp.kernel.org/pub/linux/utils/kernel/kmod/${pkg_name}-${pkg_version}.tar.xz"
        "depmod-search.conf")
pkg_shasum=('08297dfb6f2b3f625f928ca3278528af'
         '9ae9acc68ca27134f55a0959073b8e53')

do_build() {
  cd ${pkg_name}-${pkg_version}

  ./configure \
    --sysconfdir=/etc \
    --with-zlib \
    --disable-test-modules
  make
}

do_check() {
  make -C ${pkg_name}-${pkg_version} check 
}

do_package() {
  make -C${pkg_name}-${pkg_version} DESTDIR=${pkg_prefix} install

  # extra directories
  install -dm755 ${pkg_prefix}/{etc,usr/lib}/{depmod,modprobe}.d ${pkg_prefix}/sbin
  
  # add symlinks to kmod
  ln -s ../usr/bin/kmod ${pkg_prefix}/sbin/modprobe
  ln -s ../usr/bin/kmod ${pkg_prefix}/sbin/depmod

  for tool in {ins,ls,rm,dep}mod mod{probe,info}; do
    ln -s kmod ${pkg_prefix}/usr/bin/$tool
  done

  # install depmod.d file for search/ dir
  install -Dm644 ${CACHE_PATH}/depmod-search.conf ${pkg_prefix}/usr/lib/depmod.d/search.conf
}
