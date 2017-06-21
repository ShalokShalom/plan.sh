pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name="ksecrets"
pkg_version=${_kdever}
pkg_description="Ksecrets is a secrets management infrastructure aiming to replace KWallet"
pkg_upstream_url='http://kde.org/'
pkg_license=('GPL' 'FDL')
pkg_deps=("kdelibs>=${_kdever}" 'qca' "kde-workspace>=${_kdever}")
pkg_build_deps=('cmake')

pkg_source=($_mirror/${pkg_name}-$_kdever.tar.xz)
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)


do_build() {
	cd "${CACHE_PATH}"
 
        rm -rf build
	mkdir build && cd build
	cmake ../${pkg_name}-${pkg_version} \
    		-DCMAKE_BUILD_TYPE=Release \
    		-DCMAKE_INSTALL_PREFIX=/usr
	make
}

do_package() {
  	cd $CACHE_PATH/build
  	
	make DESTDIR=$pkg_prefix install
}

