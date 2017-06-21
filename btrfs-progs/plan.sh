pkg_origin=cosmos

pkg_name=btrfs-progs
pkg_version=4.11
pkg_description="Btrfs filesystem utilities."
pkg_upstream_url="https://btrfs.wiki.kernel.org/"
pkg_license=('GPL2')
pkg_deps=('glibc' 'e2fsprogs' 'lzo2' 'asciidoc')
pkg_build_deps=('git' 'xmlto')
pkg_source=("https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/${pkg_name}-v${pkg_version}.tar.xz"
        'initcpio-install-btrfs'
        'initcpio-hook-btrfs')
pkg_shasum=('25ba238f44b9a1a54e62f7b361bdc9d8'
         '5642e1524eefddf9195693cd114ecc65'
         '85ff8daca50a5ba3dff3c3e641d38b1e')

do_build() {
   cd ${pkg_name}-v${pkg_version}
   
   ./configure --prefix=/usr 
   make  
}

do_package() {
   cd ${pkg_name}-v${pkg_version}
   make prefix=${pkg_prefix}/usr udevdir=${pkg_prefix}/usr/lib/udev install

   mkdir -p ${pkg_prefix}/sbin
   ln -sf /usr/bin/btrfs ${pkg_prefix}/sbin/btrfs

   install -Dm644 ${CACHE_PATH}/initcpio-install-btrfs ${pkg_prefix}/usr/lib/initcpio/install/btrfs
   install -Dm644 ${CACHE_PATH}/initcpio-hook-btrfs ${pkg_prefix}/usr/lib/initcpio/hooks/btrfs
}
