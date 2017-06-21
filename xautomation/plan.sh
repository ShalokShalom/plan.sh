pkg_origin=cosmos

pkg_name=xautomation
pkg_version=1.09
pkg_description='Controls X from the command line and does "visual scraping".'
pkg_upstream_url='https://hoopajoo.net/projects/xautomation.html'
pkg_license=('GPL')
pkg_deps=('libpng' 'libxtst')
pkg_source=("https://hoopajoo.net/static/projects/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('16b973fdb525feed876471225bba30ed')

do_build() {

  ./configure --prefix=/usr 
  make
}

do_package() {
  
  make DESTDIR="${CACHE_PATH}" install	
}
