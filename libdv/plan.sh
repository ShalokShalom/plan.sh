pkg_origin=cosmos

pkg_name=libdv
pkg_version=1.0.0
pkg_description="The Quasar DV codec (libdv) is a software codec for DV video"
pkg_upstream_url="http://libdv.sourceforge.net/"
pkg_license=('LGPL')
pkg_deps=('popt')
pkg_build_deps=('pkgconfig' 'libxv') 
pkg_source=("http://downloads.sourceforge.net/libdv/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('f895162161cfa4bb4a94c070a7caa6c7')

do_build() {
  
  ./configure --prefix=/usr 
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install 
}

