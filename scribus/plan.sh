pkg_origin=

pkg_name=scribus
_pkg_name=Scribus
pkg_version=1.5.3
pkg_description="A desktop publishing program"
pkg_upstream_url="http://www.scribus.net"
pkg_license=('GPL')
pkg_deps=('libcups' 'lcms2' 'qt5-declarative' 'ghostscript' 'libart-lgpl' 'python2' 'libxml2' 'hyphen'
         'cairo' 'desktop-file-utils' 'shared-mime-info' 'ruby' 'aspell' 'podofo' 'librevenge' 'poppler'
         'hunspell' 'graphicsmagick' 'libvisio')
pkg_build_deps=('cmake' 'boost' 'qt5-tools')
pkg_source=("https://sourceforge.net/projects/scribus/files/scribus-devel/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz"
        "https://github.com/scribusproject/scribus/commit/dbd56212a0b9b3aa4a14d523e2499a6cf7be6e2e.diff")
# view at https://www.scribus.net/websvn/
#pkg_source=("scribus::svn://scribus.net/trunk")
pkg_shasum=('942fdd3c1927b8c84ca8abae7cc90a78'
         '5b667c0a40b7622f922c4abc976e4c3f')

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  
  sed -i 's|hunspell-1.3 hunspell-1.2|hunspell-1.3 hunspell-1.6|' cmake/modules/FindHUNSPELL.cmake
  #patch -p1 -i ${CACHE_PATH}/dbd56212a0b9b3aa4a14d523e2499a6cf7be6e2e.diff
  
}

do_build() {
	mkdir -p build
	cd build
	
	CXXFLAGS="-std=c++11"
	
	cmake ../${pkg_name}-${pkg_version} \
	   -DCMAKE_INSTALL_PREFIX=/usr \
	   -DCMAKE_BUILD_TYPE=Release \
	   -DCMAKE_SKIP_RPATH=ON \
	   -DWANT_GRAPHICSMAGICK=1 \
	   -DLIB_SUFFIX=""
	make 
}

do_package() {
	cd build
	make DESTDIR=${pkg_prefix} install

	install -Dm644 ${CACHE_PATH}/${pkg_name}-${pkg_version}/scribus.desktop \
	   ${pkg_prefix}/usr/share/applications/scribus.desktop
}
