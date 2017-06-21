pkg_origin=cosmos

pkg_name=perl-module-build
_pkg_name=Module-Build
pkg_version=0.4222
pkg_description="Build and install Perl modules"
pkg_license=('PerlArtistic' 'GPL')
pkg_upstream_url='http://search.cpan.org/dist/Module-Build'
pkg_deps=('perl')
pkg_source=("http://search.cpan.org/CPAN/authors/id/L/LE/LEONT/${_pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('96b2037b595b381ed730d84b9c1ff145')

do_build() {

  perl Build.PL installdirs=vendor
  perl Build
}

do_package() {

  perl Build install destdir=${pkg_prefix}
  rm -r ${pkg_prefix}/usr/share/man
}
