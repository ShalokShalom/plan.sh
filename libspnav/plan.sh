pkg_origin=cosmos

pkg_name=libspnav
pkg_version=0.2.3
pkg_description="Provides a free, compatible alternative, to the proprietary 3Dconnexion device driver."
pkg_upstream_url="http://spacenav.sourceforge.net/"
pkg_license=('GPL')
pkg_deps=('libx11')
pkg_source=("https://downloads.sourceforge.net/spacenav/${pkg_name}-${pkg_version}.tar.gz"
        'Makefile.in.diff')
pkg_shasum=('44d840540d53326d4a119c0f1aa7bf0a'
         'fa546d44bf8ca0d12a98aece0476b143')

do_build() {
  patch -p0 -i $CACHE_PATH/Makefile.in.diff
  
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
