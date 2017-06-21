pkg_origin=cosmos

pkg_name=perl-sdl
pkg_version=2.544
pkg_description="Simple DirectMedia Layer for Perl."
pkg_license=('LGPL')
pkg_upstream_url="http://sdl.perl.org"
pkg_deps=('perl-alien-sdl' 'perl-tie-simple'
         sdl_{net,ttf,image,mixer,gfx,pango} 'mesa' 'smpeg')
pkg_source=("http://search.cpan.org/CPAN/authors/id/F/FR/FROGGS/SDL-${pkg_version}.tar.gz")
mdsums=('ae3c7cd3ec73f96f1c10e29521b19e97')

do_build() {
  #unset CFLAGS
  perl Build.PL installdirs=vendor destdir="${pkg_prefix}"
  perl Build
}

check() {
  
  perl Build test || true
}

do_package() {
  
  perl Build install destdir="${pkg_prefix}"
}
