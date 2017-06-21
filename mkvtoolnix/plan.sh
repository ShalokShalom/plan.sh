pkg_origin=

pkg_name=mkvtoolnix
pkg_version=12.0.0
pkg_description="Set of tools to create, edit and inspect Matroska files."
pkg_license=('GPL')
pkg_upstream_url="http://www.bunkus.org/videotools/mkvtoolnix/index.html"
pkg_deps=('flac' 'libmatroska' 'libogg' 'libvorbis' 'qt5-declarative' 'xdg-utils'
         'libebml' 'zlib' 'boost-libs' 'bzip2' 'curl' 'lzo2' 'qt5-multimedia')
pkg_build_deps=('gcc' 'boost' 'ruby') # 'clang') 
pkg_source=("https://mkvtoolnix.download/sources/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('36eeea3e8afb28cf6d929e900363c283')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  #export CC=/usr/bin/clang
  #export CXX=/usr/bin/clang++
  
  ./configure --prefix=/usr --with-boost-libdir=/usr/lib
  rake
}

package () {
  cd ${pkg_name}-${pkg_version}
  
  rake DESTDIR=${pkg_prefix} install
}
