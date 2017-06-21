pkg_origin=cosmos

pkg_name=libbytesize
pkg_version=0.10
pkg_description="Tiny library that would facilitate the common operations with sizes in bytes."
pkg_upstream_url="https://github.com/rhinstaller/libbytesize"
pkg_license=('LGPL')
pkg_deps=('gmp' 'mpfr' 'pcre' 'python3-six')
pkg_build_deps=('gettext')
pkg_source=("https://github.com/rhinstaller/libbytesize/archive/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('c3f050baea4d66f858802f8c423b68c7')

do_build() {
    
    ./autogen.sh
    ./configure --prefix=/usr \
        --with-python3=yes
        
    make
}

do_package() {

    make DESTDIR=${pkg_prefix}/ install
}
 
