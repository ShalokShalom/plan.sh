pkg_origin=

pkg_name=autoconf2.13
_pkg_name=autoconf
pkg_version=2.13
pkg_description="Legacy 2.13 version of GNU tool for automatically configuring source code"
pkg_upstream_url="http://www.gnu.org/software/autoconf/"
pkg_license=('GPL2')
pkg_deps=('perl')
pkg_source=("http://ftpmirror.gnu.org/autoconf/${_pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('9de56d4a161a723228220b0f425dc711')

do_build() {
  cd ${_pkg_name}-${pkg_version} 
  
  ./configure --prefix=/usr \
    --infodir=/usr/share/info \
    --program-suffix=-2.13
  make
}

do_package() {
  cd ${_pkg_name}-${pkg_version} 
  make prefix=${pkg_prefix}/usr infodir=${pkg_prefix}/usr/share/info install
  
  mv ${pkg_prefix}/usr/share/info/autoconf{,-2.13}.info
  mv ${pkg_prefix}/usr/share/info/standards{,-2.13}.info
}
