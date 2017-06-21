pkg_origin=cosmos

pkg_name=syslinux
pkg_version=6.03
pkg_description="Collection of boot loaders that boot from FAT, ext2/3/4 and btrfs filesystems, from CDs and via PXE"
pkg_upstream_url="http://syslinux.zytor.com/"
pkg_license=('GPL2')
pkg_deps=('perl' 'glibc' 'util-linux')
pkg_build_deps=('nasm' 'python2' 'gnu-efi-libs')
optpkg_deps=('mtools:           For mkdiskimage and syslinux support'
            'gptfdisk:         For GPT support'
            'efibootmgr:       For EFI support'
            'dosfstools:       For EFI support')
backup=('boot/syslinux/syslinux.cfg')
install=syslinux.install
pkg_source=("http://www.kernel.org/pub/linux/utils/boot/syslinux/$pkg_name-${pkg_version}.tar.xz"
        'syslinux.cfg'
        'syslinux-install_update'
        'gcc5.patch')
pkg_shasum=('92a253df9211e9c20172796ecf388f13'
         '6461abfb17e54dc997cea77c7a312e20'
         '3fcba3efe6beda6fc4935c1914393377'
         '3fc0ea96652b100f71be89d6ac4df8d7')
         
do_prepare() {
    
    sed 's|/usr/man|/usr/share/man|g' -i mk/syslinux.mk
    patch -p1 -i ${CACHE_PATH}/gcc5.patch
}

_build_syslinux_bios() {
    
    rm -rf ${CACHE_PATH}/${pkg_name}-${pkg_version}-bios/ 
    cp -r ${CACHE_PATH}/${pkg_name}-${pkg_version} ${CACHE_PATH}/${pkg_name}-${pkg_version}-bios
    
    ## Do not build syslinux with default LDFLAGS
    unset LDFLAGS
    
    make bios
    make bios installer
    
}

_build_syslinux_efi64() {
    
    rm -rf ${CACHE_PATH}/${pkg_name}-${pkg_version}-efi64/ 
    cp -r ${CACHE_PATH}/${pkg_name}-${pkg_version} ${CACHE_PATH}/${pkg_name}-${pkg_version}-efi64
    
    ## Unset all compiler FLAGS for efi64 build
    unset CFLAGS
    unset CPPFLAGS
    unset CXXFLAGS
    unset LDFLAGS
    unset MAKEFLAGS
    
    make efi64
    make efi64 installer
    
}


do_build() {


    ## Build syslinux-efi
    _build_syslinux_efi64
    
    ## Build syslinux-bios
    _build_syslinux_bios
    
}

_package_syslinux_bios() {

    
    ## Install Syslinux bios
    make INSTALLROOT=${CACHE_PATH}/ AUXDIR=/usr/lib/syslinux/bios/ bios install
    
    rm ${CACHE_PATH}/usr/lib/syslinux/bios/syslinux.com
    
    ## Remove com32, dosutil and diag dirs
    rm -rf ${CACHE_PATH}/usr/lib/syslinux/bios/dosutil/
    rm -rf ${CACHE_PATH}/usr/lib/syslinux/bios/diag/
    rm -rf ${CACHE_PATH}/usr/lib/syslinux/bios/com32/
    
    ## Install docs
    install -d ${CACHE_PATH}/usr/share/doc
    cp -ar ${CACHE_PATH}/${pkg_name}-${pkg_version}/doc ${CACHE_PATH}/usr/share/doc/syslinux
    
    ## Install the default configuration
    install -D -m0644 ${CACHE_PATH}/syslinux.cfg ${CACHE_PATH}/boot/syslinux/syslinux.cfg
    
    ## Install the installation and update script
    ## This script is maintained at git://gist.github.com/772138.git
    ## Script not yet updated for syslinux-efi
    install -D -m0755 ${CACHE_PATH}/syslinux-install_update ${CACHE_PATH}/usr/sbin/syslinux-install_update
    
}

do_package() { 

    make INSTALLROOT=${CACHE_PATH}/ AUXDIR=/usr/lib/syslinux/ efi64 install

    _package_syslinux_bios
    
}
