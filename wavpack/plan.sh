pkg_origin=cosmos

pkg_name=wavpack
pkg_version=5.1.0
pkg_description="Audio compression format with lossless, lossy, and hybrid compression modes"
pkg_upstream_url="http://www.wavpack.com/"
pkg_license=('custom')
pkg_deps=('glibc')
pkg_source=("http://www.wavpack.com/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('7f06272651f0c2292c1d0ba353386782')

do_build() {
	
	./configure --prefix=/usr \
	      --libdir=/usr/lib \
	      --enable-mmx \
	      --disable-static
	make
}

do_package() {
	make DESTDIR=${CACHE_PATH} install 
	
	install -Dm644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
