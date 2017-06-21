pkg_origin=cosmos

pkgbase=libofx
pkg_name=('libofx' 'libofx-doc')
pkg_version=0.9.11
pkg_description="API for the OFX banking standard"
pkg_upstream_url="https://github.com/libofx/libofx"
pkg_license=('GPL')
pkg_deps=('opensp' 'curl' 'libxml++')
checkpkg_deps=('gnupg')
pkg_source=("https://downloads.sourceforge.net/libofx/${pkgbase}-${pkg_version}.tar.gz")
pkg_shasum=('b0b9ed7ea0a94990d760464bebea8666' )

do_build() {

  ./configure --prefix=/usr
  make CXXFLAGS="-std=c++11"
}

check() {
  
  make check
}

package_libofx() {
  options=('!libtool' '!docs')

  make DESTDIR=$pkg_prefix install
}

package_libofx-doc() {
  pkg_description="Documention of the OFX banking standard API"
  pkg_deps=()

  make DESTDIR=$pkg_prefix install-docDATA
  make -C doc DESTDIR=$pkg_prefix install
}
