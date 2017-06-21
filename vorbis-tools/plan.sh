pkg_origin=cosmos

pkg_name=vorbis-tools
pkg_version=1.4.0.1
pkg_description="Extra tools for Ogg-Vorbis"
pkg_upstream_url='http://www.xiph.org/vorbis/'
pkg_license=('GPL2')
pkg_deps=('libao' 'libvorbis' 'curl' 'flac')
pkg_build_deps=('subversion')
#pkg_source=("http://downloads.xiph.org/releases/vorbis/${pkg_name}-${pkg_version}.tar.gz")
pkg_source=('svn+http://svn.xiph.org/trunk/vorbis-tools/')
pkg_shasum=('SKIP')

do_build() {
  
  ./autogen.sh
  ./configure --prefix=/usr \
    --without-speex \
    --enable-vcut 
  make 
}

do_package() {
  
  make DESTDIR=${CACHE_PATH} install 
}
