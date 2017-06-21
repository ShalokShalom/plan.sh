pkg_origin=cosmos

pkgbase=lvm2
pkg_name=('lvm2' 'device-mapper')
pkg_version=2.02.171
pkg_upstream_url="https://sourceware.org/lvm2/"
pkg_license=('GPL2' 'LGPL2.1')
pkg_build_deps=('systemd')
pkg_source=("https://mirrors.kernel.org/sources.redhat.com/lvm2/LVM2.${pkg_version}.tgz"
        'lvm2_install'
        'lvm2_hook'
        '11-dm-initramfs.rules'
        'sd-lvm2')
pkg_shasum=('153b7bb643eb26073274968e9026fa8f'
         '8cfc93d5fe9be1cd0a37dd4fbe3cc2ec'
         'b25cfb248e66e0f76e7aafa6715d620a'
         '69e40679cd8b3658bfc619e48baae125'
         '00e15be4621b47c8940c64c419bf7ff3')

do_build() {
  cd LVM2.${pkg_version}
  unset LDFLAGS

  ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --with-udev-prefix=/usr \
    --with-systemdsystemunitdir=/usr/lib/systemd/system --with-default-pid-dir=/run \
    --with-default-dm-run-dir=/run --with-default-run-dir=/run/lvm \
    --enable-pkgconfig --enable-readline --enable-dmeventd --enable-cmdlib --enable-applib \
    --enable-udev_sync --enable-udev_rules --with-default-locking-dir=/run/lock/lvm \
    --enable-lvmetad --enable-udev-systemd-background-jobs --sbindir=/usr/sbin
  make
}

package_device-mapper() {
  pkg_description="Device mapper userspace library and tools"
  pkg_upstream_url="http://sourceware.org/dm/"
  pkg_deps=('glibc' 'systemd')

  cd LVM2.${pkg_version}
  make DESTDIR=${pkg_prefix} install_device-mapper
  # extra udev rule for device-mapper in initramfs
  install -D -m644 ${CACHE_PATH}/11-dm-initramfs.rules ${pkg_prefix}/usr/lib/initcpio/udev/11-dm-initramfs.rules

  make DESTDIR=${pkg_prefix} install_systemd_units
  rm -f ${pkg_prefix}/usr/lib/systemd/system/{blk-availability.service,lvm2-*}
  install -d -m755 ${pkg_prefix}/usr/lib/systemd/system/sockets.target.wants
  ln -sf ../dm-event.socket ${pkg_prefix}/usr/lib/systemd/system/sockets.target.wants/dm-event.socket
}

package_lvm2() {
  pkg_description="Logical Volume Manager 2 utilities"
  pkg_deps=('bash' "device-mapper>=${pkg_version}" 'systemd' 'readline')
  conflicts=('lvm' 'mkinitcpio<0.7')
  backup=('etc/lvm/lvm.conf')
  options=('!makeflags')
  install=lvm2.install

  cd LVM2.${pkg_version}
  make DESTDIR=${pkg_prefix} install_lvm2
  # install applib
  make -C liblvm DESTDIR=${pkg_prefix} install
  # /etc directories
  install -d ${pkg_prefix}/etc/lvm/{archive,backup}

  install -D -m644 ${CACHE_PATH}/lvm2_hook ${pkg_prefix}/usr/lib/initcpio/hooks/lvm2
  install -D -m644 ${CACHE_PATH}/lvm2_install ${pkg_prefix}/usr/lib/initcpio/install/lvm2
  install -D -m644 ${CACHE_PATH}/sd-lvm2 ${pkg_prefix}/usr/lib/initcpio/install/sd-lvm2
 
  make DESTDIR=${pkg_prefix} install_systemd_units
  rm -f ${pkg_prefix}/usr/lib/systemd/system/dm-*
  install -d -m755 ${pkg_prefix}/usr/lib/systemd/system/sysinit.target.wants
  ln -sf /usr/lib/systemd/system/lvm2-lvmetad.socket ${pkg_prefix}/usr/lib/systemd/system/sysinit.target.wants/lvm2-lvmetad.socket
  make DESTDIR=${pkg_prefix} install_systemd_generators
  # enable lvmetad
  sed 's|use_lvmetad = 0|use_lvmetad = 1|' -i "${pkg_prefix}/etc/lvm/lvm.conf"
}
