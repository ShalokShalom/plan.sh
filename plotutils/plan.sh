pkg_origin=cosmos

pkg_name=plotutils
pkg_version=2.6
pkg_description="Set of utilities and libraries for plotting."
pkg_upstream_url="http://directory.fsf.org/graphics/plotutils.html"
pkg_license=("GPL")
pkg_deps=('libpng' 'gcc-libs' 'libxaw')
pkg_source=("http://ftp.gnu.org/pub/gnu/plotutils/${pkg_name}-${pkg_version}.tar.gz"
        'plotutils-2.6-libpng-1.5.patch')
pkg_shasum=('c08a424bd2438c80a786a7f4b5bb6a40'
         'a155e64a8b0c74e14b774e19edb4554b')


do_build() {
  patch -p0 -i ../plotutils-2.6-libpng-1.5.patch
  
  ./configure --prefix=/usr \
	--with-gnu-ld \
	--with-x \
	--enable-libplotter
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
