pkg_origin=

pkg_name=dvdauthor
pkg_version=0.7.2
pkg_description="DVD authoring tools"
pkg_upstream_url="http://dvdauthor.sourceforge.net/"
pkg_license=('GPL')
pkg_deps=('libdvdread' 'imagemagick' 'libxml2' 'libpng' 'fribidi')
pkg_source=("http://downloads.sourceforge.net/dvdauthor/${pkg_name}-${pkg_version}.tar.gz"
        'glibc220.patch')
pkg_shasum=('1173dcb8d40e74fc90c0f3a25dbd642d'
         '61a24ecc4ffd7d4fa211bd716a90a8f3')

do_build() {
  cd ${pkg_name}
  #patch -p1 -i ${CACHE_PATH}/glibc220.patch
  
  ./configure --prefix=/usr --sysconfdir=/etc 
  make 
}

do_package() {
  cd ${pkg_name}

  make DESTDIR=${pkg_prefix} install 
}
