pkg_origin=cosmos

pkg_name=xmlto
pkg_version=0.0.28
pkg_description="Convert xml to many other formats"
pkg_upstream_url="http://cyberelk.net/tim/software/xmlto/"
# should move soon to:
# https://pagure.io/xmlto
pkg_license=('GPL')
pkg_deps=('libxslt' 'perl-yaml-syck' 'perl-test-pod')
pkg_build_deps=('docbook-xsl')
pkg_source=("https://fedorahosted.org/releases/x/m/${pkg_name}/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('93bab48d446c826399d130d959fe676f')

do_build() {
  cd "$CACHE_PATH/${pkg_name}-${pkg_version}"

  ./configure BASH=/bin/bash \
       --prefix=/usr \
       --mandir=/usr/share/man
  make
}

do_package() {
  cd "$CACHE_PATH/${pkg_name}-${pkg_version}"

  make DESTDIR="${pkg_prefix}" install
}

