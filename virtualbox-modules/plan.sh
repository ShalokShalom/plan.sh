pkg_origin=

_extramodules=extramodules-4.11
_kernver="$(cat /lib/modules/$_extramodules/version)"

pkg_name=virtualbox-modules
pkg_version=5.1.22
_pkg_version=5.1.22
pkg_description="Kernel modules for VirtualBox"
pkg_upstream_url="http://www.virtualbox.org"
pkg_license=('GPL-2')
pkg_deps=('linux>=4.11' 'linux<4.12')
pkg_build_deps=('linux-headers')
pkg_source=("https://sourceforge.net/projects/kaosx/files/sources/virtualbox-modules/vbox-kernel-module-src-${_pkg_version}.tar.xz"
        'virtualbox-modules-depmod.patch'
        'vbox-modules.conf')
install=${pkg_name}.install
pkg_shasum=('5d4a0f206bfd5f8d208d3f481c793444'
         'c9f84fb084a79275d269c542ff53ba4d'
         'f122361a8d2075e4dc819757b6ba34cc')

do_prepare() {
    cd vbox-kernel-module-src-${_pkg_version}
    
    patch -p0 -i ${CACHE_PATH}/virtualbox-modules-depmod.patch
}

do_build() {
    cd vbox-kernel-module-src-${_pkg_version}
    mkdir -p lib/modules/${_kernver}/misc
    
    make KERN_DIR=/lib/modules/${_kernver}/build MODULE_DIR_TST=${pkg_prefix}/lib/modules/${_kernver} \
        MODULE_DIR=${pkg_prefix}/lib/modules/${_kernver}/misc
}

do_package() {
    cd vbox-kernel-module-src-${_pkg_version}
    
    make KERN_DIR=/lib/modules/${_kernver}/build MODULE_DIR_TST=${pkg_prefix}/lib/modules/${_kernver} \
        MODULE_DIR=${pkg_prefix}/lib/modules/${_kernver}/misc INSTALL_MOD_PATH=${pkg_prefix} install

    sed -i -e "s/EXTRAMODULES='.*'/EXTRAMODULES='${_extramodules}'/" "${startdir}/virtualbox-modules.install"
    
    install -D -m644 ../vbox-modules.conf ${pkg_prefix}/etc/modules-load.d/vbox-modules.conf
}
