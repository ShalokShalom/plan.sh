pkg_origin=cosmos

pkg_name=ktoblzcheck
pkg_version=1.49
pkg_description="Tool for verification of account numbers and bank codes"
pkg_license=('LGPL')
pkg_upstream_url="http://ktoblzcheck.sourceforge.net/"
pkg_deps=('python3' 'gcc-libs')
pkg_source=("https://downloads.sourceforge.net/project/ktoblzcheck/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('2ea1b01a931eb1e52b0ca0e07cb72435')

do_build() {
  
  ./configure --prefix=/usr --enable-python
  make
}

do_package() {
  
   make DESTDIR=${pkg_prefix} install
}
