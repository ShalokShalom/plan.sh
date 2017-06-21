pkg_origin=cosmos

pkg_name=efivar
_pkg_name=vathpela-efivar
_commit=70e63d4
pkg_version=31
pkg_description="Library to manipulate EFI variables"
pkg_upstream_url="https://github.com/rhinstaller/efivar"
pkg_license=('LGPL2.1')
pkg_deps=('popt')
pkg_source=("https://github.com/rhinstaller/efivar/releases/download/${pkg_version}/efivar-${pkg_version}.tar.bz2"
        'compiler.patch')
pkg_shasum=('af30079fa7c95dd9843cee75b6f96590'
         '76d1d1cc85f021ea9d820395af8fa8d4')

do_build() {
	cd ${pkg_name}-${pkg_version}/
	#patch -p1 -i $CACHE_PATH/compiler.patch
	
	unset CFLAGS
	unset CPPFLAGS
	unset CXXFLAGS
	unset LDFLAGS
	unset MAKEFLAGS
	
	sed 's|-rpath=$(TOPDIR)/src/|-rpath=$(libdir)|g' -i ${CACHE_PATH}/${pkg_name}-${pkg_version}/src/test/Makefile || true
	sed 's|-O0|-Os|g' -i "${CACHE_PATH}/efivar/Make.defaults" || true
	
	make libdir="/usr/lib/" bindir="/usr/bin/" mandir="/usr/share/man/" includedir="/usr/include/" V=1 -j1
	echo
}

do_package() {
	
	cd ${pkg_name}-${pkg_version}/
	
	make -j1 V=1 DESTDIR=${pkg_prefix}/ libdir="/usr/lib/" bindir="/usr/bin/" mandir="/usr/share/man/" includedir="/usr/include/" install
	echo
	
	#rm ${pkg_prefix}/usr/bin/efivar-static
}
