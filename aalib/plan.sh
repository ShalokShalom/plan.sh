pkg_origin=cosmos

pkg_name=aalib
pkg_version=1.4rc5
_pkg_version=1.4.0
pkg_description="AAlib is a portable ASCII art GFX library"
pkg_upstream_url="http://aa-project.sourceforge.net/aalib/"
pkg_license=('LGPL')
pkg_deps=('glibc' 'ncurses' 'gpm' 'libx11')
pkg_source=("https://downloads.sourceforge.net/sourceforge/aa-project/${pkg_name}-${pkg_version}.tar.gz"
        'aclocal-fixes.patch')
pkg_shasum=('9801095c42bba12edebd1902bcf0a990'
         '863a96a6689aa7ee073ca448bc2f133d')

do_build() {
  patch -p0 -i ${CACHE_PATH}/aclocal-fixes.patch
  
  ./configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
