pkg_origin=cosmos

pkg_name=npapi-sdk
pkg_version=0.27.2
pkg_description="Netscape Plugin API (NPAPI)"
pkg_upstream_url="https://bitbucket.org/mgorny/npapi-sdk"
pkg_license=('MPL')
pkg_source=("https://bitbucket.org/mgorny/npapi-sdk/downloads/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('e81db61e206cd615cf56c4a9f301e636')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}

