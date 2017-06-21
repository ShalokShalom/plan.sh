pkg_origin=cosmos

pkg_name=gnu-efi-libs
pkg_version=3.0.5
_pkg_version=3.0.5
pkg_description="Library for building UEFI Applications using GNU toolchain"
pkg_upstream_url="https://sourceforge.net/projects/gnu-efi/"
pkg_license=('GPL')
pkg_build_deps=('pciutils')
pkg_source=("https://download.sourceforge.net/gnu-efi/gnu-efi-${pkg_version}.tar.bz2")
pkg_shasum=('1f719c9c135778aa6b087b89a1cc2423')

do_build() {
	
	make lib gnuefi inc apps
}

do_package() {
	
	make INSTALLROOT=${pkg_prefix} PREFIX=/usr LIBDIR=/usr/lib install
	
	install -d ${pkg_prefix}/usr/share/gnu-efi/apps/x86_64/
	install -D -m0644 ${CACHE_PATH}/gnu-efi-${_pkg_version}/x86_64/apps/*.efi ${pkg_prefix}/usr/share/gnu-efi/apps/x86_64/
}
