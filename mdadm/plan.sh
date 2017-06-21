pkg_origin=cosmos

pkg_name=mdadm
pkg_version=4.0
pkg_description="A tool for managing/monitoring Linux md device arrays, also known as Software RAID"
pkg_license=('GPL')
pkg_upstream_url="http://git.kernel.org/cgit/utils/mdadm/mdadm.git/"
pkg_deps=('glibc')
backup=('etc/mdadm.conf')
pkg_source=("https://www.kernel.org/pub/linux/utils/raid/mdadm/mdadm-${pkg_version}.tar.xz"
        'mdadm.conf' 
        'mdadm_install'
        'mdadm_hook'
        'mdadm_udev_install'
        'disable-werror.patch')
pkg_shasum=('2cb4feffea9167ba71b5f346a0c0a40d'
         '5a37c112aa07dccdde62f9fa5b888607'
         '6e1a3377e2ac33e9fb222ab38050c654'
         '8e02ee595dfa4e5178ed8886e822cf3a'
         '7b052d051565d8128b09ca6f673d1b08'
         '599745ed2bec4489e83991cff89c46ee')

do_build() {
  cd ${pkg_name}-${pkg_version}
  patch -p0 -i ${CACHE_PATH}/disable-werror.patch
  
  make CXFLAGS="$CFLAGS"
  make MDASSEMBLE_AUTO=1 mdassemble

}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make INSTALL=/usr/bin/install DESTDIR=${pkg_prefix} install
  make SYSTEMD_DIR=${pkg_prefix}/usr/lib/systemd/system install-systemd
  
  install -D -m755 mdassemble ${pkg_prefix}/sbin/mdassemble
  install -D -m644 ../mdadm.conf ${pkg_prefix}/etc/mdadm.conf
  install -D -m644 ../mdadm_install ${pkg_prefix}/usr/lib/initcpio/install/mdadm
  install -D -m644 ../mdadm_hook ${pkg_prefix}/usr/lib/initcpio/hooks/mdadm
  install -D -m644 ../mdadm_udev_install ${pkg_prefix}/usr/lib/initcpio/install/mdadm_udev
}
