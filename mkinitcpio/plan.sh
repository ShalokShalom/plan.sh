pkg_origin=cosmos

pkg_name=mkinitcpio
pkg_version=23
pkg_description="Modular initramfs image creation utility"
pkg_upstream_url="https://projects.archlinux.org/mkinitcpio.git/"
pkg_license=('GPL')
pkg_deps=('awk' 'mkinitcpio-busybox' 'kmod' 'util-linux' 'libarchive' 'coreutils'
         'bash' 'findutils' 'grep' 'filesystem>=2016.11' 'gzip' 'systemd')
optpkg_deps=('xz: Use lzma or xz compression for the initramfs image'
            'bzip2: Use bzip2 compression for the initramfs image'
            'mkinitcpio-nfs-utils: Support for root filesystem on NFS')
backup=('etc/mkinitcpio.conf')
pkg_source=("https://sources.archlinux.org/other/mkinitcpio/${pkg_name}-${pkg_version}.tar.gz"
        'init.diff')
install=mkinitcpio.install
pkg_shasum=('ce81c73dd622e359ee732fa6022b9891'
         '5bce3b1cf3de654151d5522086431624')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  patch -p0 -i ${CACHE_PATH}/init.diff
}

do_package() {
   make -C ${pkg_name}-${pkg_version} DESTDIR=${pkg_prefix} install
}

