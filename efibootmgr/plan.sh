pkg_origin=cosmos

pkg_name=efibootmgr
pkg_version=15
_commit=0bb83cf5640ef834eb4c32a146d140c40034247b
pkg_description="Tool to modify UEFI Firmware Boot Manager Variables."
pkg_upstream_url="https://github.com/rhinstaller/efibootmgr"
pkg_license=('GPL2')
pkg_deps=('zlib' 'pciutils' 'efivar')
pkg_source=("https://github.com/rhinstaller/efibootmgr/releases/download/${pkg_version}/${pkg_name}-${pkg_version}.tar.bz2")
#pkg_source=("https://github.com/rhinstaller/efibootmgr/archive/${_commit}.zip")
pkg_shasum=('62597b082f27da940bf18f0ec8c5907b')

build () {	
	cd ${pkg_name}-${pkg_version}/
	
	make EXTRA_CFLAGS="-Os" EFIDIR="/boot"
	echo
}


do_package() {
    cd ${pkg_name}-${pkg_version}/
        
    install -d ${pkg_prefix}/usr/bin/
    install -d ${pkg_prefix}/usr/share/man/man8/
	
	install -D -m0755 src/efibootmgr ${pkg_prefix}/usr/sbin/efibootmgr
	install -D -m644 src/efibootmgr.8 ${pkg_prefix}/usr/share/man/man8/efibootmgr.8
}
