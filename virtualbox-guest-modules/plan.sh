pkg_origin=

_extramodules=extramodules-4.11
_kernver="$(cat /lib/modules/$_extramodules/version)"

pkg_name=virtualbox-guest-modules
pkg_version=5.1.22
_pkg_version=5.1.22
pkg_description='VirtualBox guest kernel modules, to use with guest-utils'
pkg_license=('GPL' 'custom')
pkg_upstream_url='http://virtualbox.org'
pkg_deps=('linux>=4.11' 'linux<4.12')
pkg_build_deps=('linux-headers')
install=virtualbox-guest-modules.install
pkg_source=("https://sourceforge.net/projects/kaosx/files/sources/virtualbox-modules/vbox-guest-module-src-${_pkg_version}.tar.xz"
        'vbox-guest-modules.conf')
pkg_shasum=('5055a39a8a367cdf6a62ad024bf87437'
         'ac6011232f39821417e1ab6b17fd1bd1')

do_build() {
    cd vbox-guest-module-src-${_pkg_version}
    
    mkdir -p lib/modules/${_kernver}/misc
    
    make KERN_DIR=/lib/modules/${_kernver}/build MODULE_DIR_TST=${pkg_prefix}/lib/modules/${_kernver} \
        MODULE_DIR=${pkg_prefix}/lib/modules/${_kernver}/misc
}



do_package() {
    cd vbox-guest-module-src-${_pkg_version}
    
    install -dm755 ${pkg_prefix}/lib/modules/$_extramodules/
    install -m644 *.ko ${pkg_prefix}/lib/modules/$_extramodules/
    
    sed -i -e "s/EXTRAMODULES='.*'/EXTRAMODULES='${_extramodules}'/" ${startdir}/virtualbox-guest-modules.install
    
    # check if needed to activate
    #install -D -m644 ../vbox-guest-modules.conf ${pkg_prefix}/etc/modules-load.d/vbox-guest-modules.conf
}
    



