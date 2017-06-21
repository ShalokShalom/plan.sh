pkg_origin=cosmos

pkg_name=vcdimager
pkg_version=0.7.24
pkg_description="full-featured mastering suite for authoring disassembling and analyzing Video CD's and Super Video CD's"
pkg_license=('GPL')
pkg_upstream_url="http://www.vcdimager.org/"
pkg_deps=('libcdio' 'libxml2' 'popt')
pkg_source=("ftp://ftp.gnu.org/gnu/vcdimager/${pkg_name}-${pkg_version}.tar.gz"
        'libcdio.patch')
pkg_shasum=('3af22978fd79c79d5fda6513b6811145'
         'dde30a72fb13a825588450aefa3f4b72')

do_build() {
  patch -p1 -i $CACHE_PATH/libcdio.patch
  
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${CACHE_PATH} install
}
