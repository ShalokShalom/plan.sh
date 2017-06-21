pkg_origin=

pkg_name=scilab
pkg_version=6.0.0
pkg_description="Scilab is a scientific software package for numerical computations"
pkg_upstream_url="http://www.scilab.org/"
pkg_license=('custom:CeCILL')
pkg_deps=('libxi' 'libgl' 'libxml2' 'libxtst' 'libxss' 'java-runtime')
pkg_build_deps=('patch')
pkg_source=("http://www.scilab.org/download/${pkg_version}/scilab-${pkg_version}.bin.linux-x86_64.tar.gz"
        'fix-thirdparty-path.patch'
        'scilab.desktop')
pkg_shasum=('6095de25900c860c5ddceeef652bbf6a'
         '85cdefb014b6af91ff39d84bbe46e2d6'
         'ad6286f324891fe8b86c60e4012a36b7')

do_build() {
	cd scilab-${pkg_version}
	
	#patch -p1 -i ${CACHE_PATH}/fix-thirdparty-path.patch
}

do_package() {
	install -d ${pkg_prefix}/usr/lib &&
	install -d ${pkg_prefix}/usr/share/licenses/${pkg_name} &&
	install -d ${pkg_prefix}/usr/share/applications &&
	
	cp -r ${CACHE_PATH}/scilab-${pkg_version}/bin ${pkg_prefix}/usr &&
	cp -r ${CACHE_PATH}/scilab-${pkg_version}/include ${pkg_prefix}/usr &&
	cp -r ${CACHE_PATH}/scilab-${pkg_version}/share ${pkg_prefix}/usr &&
	cp -r ${CACHE_PATH}/scilab-${pkg_version}/lib/scilab ${pkg_prefix}/usr/lib &&
	cp -r ${CACHE_PATH}/scilab-${pkg_version}/lib/pkgconfig ${pkg_prefix}/usr/lib &&
	cp -r ${CACHE_PATH}/scilab-${pkg_version}/lib/thirdparty ${pkg_prefix}/usr/lib/scilab &&
	cp -r ${CACHE_PATH}/scilab-${pkg_version}/thirdparty ${pkg_prefix}/usr/share/scilab &&
	install --mode=644 ${CACHE_PATH}/scilab.desktop ${pkg_prefix}/usr/share/applications &&
	install --mode=644 ${CACHE_PATH}/scilab-${pkg_version}/COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name} 
}
