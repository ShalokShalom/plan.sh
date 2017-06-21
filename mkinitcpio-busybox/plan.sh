pkg_origin=cosmos

pkg_name=mkinitcpio-busybox
pkg_version=1.25.1
pkg_description="base initramfs tools"
pkg_upstream_url="http://www.busybox.net/"
pkg_license=('GPL')
pkg_deps=('glibc')
pkg_source=("http://busybox.net/downloads/busybox-${pkg_version}.tar.bz2"
        'config'
        'glibc.patch')
pkg_shasum=('4f4c5de50b479b11ff636d7d8eb902a2'
         '203eb6984b2b1b1ff01d721f16f7d779'
         'bcaf2fa775b8c598a83a4765fc5d4bb3')

do_build() {
  cd busybox-${pkg_version}

  local safeflags="${CARCH/_/-} -mtune=generic -Os -pipe -fno-strict-aliasing"
  sed 's|^\(CONFIG_EXTRA_CFLAGS\)=.*|\1="-march='"$safeflags"'"|' ${CACHE_PATH}/config > .config
  patch -p1 -i ${CACHE_PATH}/glibc.patch

  make
}

do_package() {
  install -Dm755 ${CACHE_PATH}/busybox-${pkg_version}/busybox ${pkg_prefix}/usr/lib/initcpio/busybox
}

