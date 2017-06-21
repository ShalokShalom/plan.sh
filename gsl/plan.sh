pkg_origin=cosmos

pkg_name=gsl
pkg_version=2.3
pkg_description="The GNU Scientific Library (GSL) is a modern numerical library for C and C++ programmers"
pkg_upstream_url="https://www.gnu.org/software/gsl/gsl.html"
pkg_license=('GPL')
pkg_deps=('glibc' 'bash')
pkg_source=("ftp://ftp.gnu.org/gnu/gsl/$pkg_name-$pkg_version.tar.gz")
pkg_shasum=('905fcbbb97bc552d1037e34d200931a0')

do_build() {
    unset LDFLAGS

    ./configure --prefix=/usr
    make 
}

check() {
    
    make -k check || true
}

do_package() {
    
    make DESTDIR=${pkg_prefix} install 
}
