pkg_origin=cosmos

pkg_name=perl-yaml-syck
_pkg_name=YAML-Syck
pkg_version=1.30
_pkg_version=1.30
pkg_description="Fast, lightweight YAML loader and dumper"
pkg_license=('custom')
pkg_upstream_url="http://search.cpan.org/dist/${_pkg_name}/"
pkg_deps=('perl')
checkpkg_deps=('perl-test-pod')
pkg_source=("http://www.cpan.org/authors/id/T/TO/TODDR/${_pkg_name}-${_pkg_version}.tar.gz")
pkg_shasum=('45e60197ea93dc4d3cbcf8aeab982054')

do_build() {
  cd ${_pkg_name}-${_pkg_version}

  perl Makefile.PL INSTALLDIRS=vendor
  make
}

do_check() {
  cd ${_pkg_name}-${_pkg_version}
  
  make test
}

do_package() {
  cd ${_pkg_name}-${_pkg_version}
  make install DESTDIR=${pkg_prefix}

  install -D -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/COPYING
}
