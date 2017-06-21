pkg_origin=cosmos

pkg_name=hwdetect
pkg_version=2016.01
pkg_description="Hardware detection script with loading modules and mkinitcpio.conf"
pkg_license=('GPL')
pkg_deps=('sh' 'awk' 'grep' 'coreutils' 'sed' 'e2fsprogs')
pkg_deps=('cryptsetup: for encrypt mkinitcpio config support'
            'dmraid:     for dmraid mkinitcpio config support'
            'lvm2:       for lvm2 mkinitcpio config support'
            'mdadm:      for raid mkinitcpio config support')
pkg_source=('hwdetect')
pkg_shasum=('adf3a8c9020ef7560b1e1dbbcd91f824')

do_package() {
  install -D -m 755 ${CACHE_PATH}/hwdetect ${pkg_prefix}/sbin/hwdetect
}
