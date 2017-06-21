pkg_origin=cosmos

pkg_name=facile
pkg_version=1.1.3
pkg_description="A Functional Constraint Library"
pkg_upstream_url="http://www.recherche.enac.fr/opti/facile/"
pkg_license=('LGPL')
pkg_build_deps=('ocaml')
pkg_source=("http://opti.recherche.enac.fr/facile/distrib/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('172c4fbea636a8fa575b988390639d8d')

do_build() {
  
  ./configure
  make
}

do_package() {
  
  install -d ${pkg_prefix}/usr/lib/ocaml/facile
  install -D -m 644 facile.cmxa facile.cmi facile.cma facile.a ${pkg_prefix}/usr/lib/ocaml/facile
}

