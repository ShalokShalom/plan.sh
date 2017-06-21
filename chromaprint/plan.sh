pkg_origin=cosmos

pkg_name=chromaprint
pkg_version=1.4.2
pkg_description='Client-side library that implements a custom algorithm for extracting fingerprints from any audio source'
pkg_upstream_url='http://acoustid.org/chromaprint/'
pkg_license=('LGPL')
pkg_deps=('ffmpeg')
pkg_build_deps=('cmake')
pkg_source=("https://bitbucket.org/acoustid/chromaprint/downloads/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('895c42ba6d769840a2e10e507ad9f14d')

do_build() {
        
   cmake \
	-DCMAKE_INSTALL_PREFIX=/usr \
	-DCMAKE_BUILD_TYPE=Release \
	-DBUILD_TOOLS=ON \
	.
   make
}

do_package() {
	
   make DESTDIR=${pkg_prefix} install
}
