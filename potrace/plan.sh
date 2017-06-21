pkg_origin=
 
pkg_name=potrace
pkg_version=1.14
pkg_description='Tool for transforming a bitmap into a smooth, scalable image. The input is a bitmap (PBM, PGM, PPM, or BMP format)'
pkg_upstream_url='http://potrace.sourceforge.net/'
pkg_license=('GPL')
pkg_deps=('zlib')
pkg_source=("https://sourceforge.net/projects/potrace/files/${pkg_version}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('cd8086c8afa700ad912fd98562299360')

do_build() {
    cd ${pkg_name}-${pkg_version}

    ./configure \
        --prefix=/usr \
        --mandir=/usr/share/man \
        --with-libpotrace \

    make
}

do_package() {
    cd ${pkg_name}-${pkg_version}

    make DESTDIR=${pkg_prefix} install
}
