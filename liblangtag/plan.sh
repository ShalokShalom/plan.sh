pkg_origin=cosmos

pkg_name=liblangtag
pkg_version=0.6.2
pkg_description="Interface library to access/deal with tags for identifying languages, which is described in RFC 5646."
pkg_upstream_url="http://tagoh.bitbucket.org/liblangtag/"
pkg_license=('GPL3' 'Mozilla Public License, v. 2.0')
pkg_deps=('gobject-introspection' 'libxml2')
pkg_build_deps=('boost' 'glm' 'cppunit' 'mdds')
pkg_source=("https://bitbucket.org/tagoh/liblangtag/downloads/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('284f120247323a35122ab32b4b359c45')

do_build() {

  ./configure \
      --prefix=/usr 
  make
}

check() {
  
  make check
}

do_package() {

  make DESTDIR=$pkg_prefix install
}
