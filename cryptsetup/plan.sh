pkg_origin=cosmos

pkg_name=cryptsetup
pkg_version=1.7.5
pkg_description="Utility used to conveniently setup disk encryption based on DMCrypt kernel module."
pkg_license=('GPL')
pkg_upstream_url="https://gitlab.com/cryptsetup/cryptsetup/blob/master/README.md"
pkg_deps=('device-mapper' 'libgcrypt' 'popt' 'util-linux')
pkg_source=("https://www.kernel.org/pub/linux/utils/cryptsetup/v1.7/${pkg_name}-${pkg_version}.tar.xz"
        'encrypt_hook'
        'encrypt_install'
        'sd-encrypt')
pkg_shasum=('d2d668223e795dcf750da44dc3e7076b'
         'db61e4cb956fd55ab0aa7eb49d761e22'
         'b20fc8f9c304e8b63eff3435d540e41c'
         '8861a7518f4dfd9062d1312aebf71155')
do_build() {
  cd ${pkg_name}-${pkg_version}
  
  ./configure --prefix=/usr \
        --disable-static \
        --enable-cryptsetup-reencrypt
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix} install

  install -D -m644 ${CACHE_PATH}/encrypt_hook ${pkg_prefix}/usr/lib/initcpio/hooks/encrypt
  install -D -m644 ${CACHE_PATH}/encrypt_install ${pkg_prefix}/usr/lib/initcpio/install/encrypt
  install -D -m644 ${CACHE_PATH}/sd-encrypt ${pkg_prefix}/usr/lib/initcpio/install/sd-encrypt
}

