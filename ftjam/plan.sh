pkg_origin=cosmos

pkg_name=ftjam
pkg_version=2.5.3rc2
pkg_description='FT Jam, small open-source build tool that can be used as a replacement for Make'
pkg_upstream_url="http://freetype.org/jam/"
pkg_license=('custom')
pkg_deps=('glibc')
pkg_source=("http://david.freetype.org/jam/${pkg_name}-${pkg_version}.tar.bz2" 
        'license.txt')
pkg_shasum=('911cc4191b3e7213905d107962b4529b'
         'ef8ff7da77fe60e25d1e3e740600f1f0')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -D -m644 ${CACHE_PATH}/license.txt ${pkg_prefix}/usr/share/licenses/${pkg_name}/license.txt
}
