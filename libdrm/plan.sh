pkg_origin=cosmos

pkg_name=libdrm
pkg_version=2.4.81
pkg_description="Userspace interface to kernel DRM services"
pkg_upstream_url="https://dri.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('glibc' 'libpciaccess')
pkg_build_deps=('cairo' 'valgrind' 'xorg-util-macros')
pkg_source=("https://dri.freedesktop.org/libdrm/${pkg_name}-${pkg_version}.tar.bz2"
        'COPYING')
pkg_shasum=('d04f3567f0a812188d06f860fded5ab7'
         'ba65e71c481b94ef0fb6c23c7f21ffa1')

do_build() {
  
  ./configure --prefix=/usr \
      --enable-udev \
      --enable-omap-experimental-api \
      --enable-exynos-experimental-api 
  make
}

check() {
  
  make -k check
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -m755 -d ${pkg_prefix}/usr/share/licenses/${pkg_name}
  install -m644 ${CACHE_PATH}/COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/
}
