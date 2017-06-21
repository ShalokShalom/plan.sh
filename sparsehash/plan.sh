pkg_origin=

pkg_name=sparsehash
pkg_version=2.0.3
pkg_description="Library that contains several hash-map implementations"
pkg_upstream_url="https://github.com/sparsehash/sparsehash"
pkg_license=('BSD')
pkg_source=("https://github.com/sparsehash/sparsehash/archive/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('d8d5e2538c1c25577b3f066d7a55e99e')

do_build() {
    cd ${pkg_name}-${pkg_name}-${pkg_version}

    ./configure --prefix=/usr
    make
}

do_package() {
    cd ${pkg_name}-${pkg_name}-${pkg_version}
    make DESTDIR=${pkg_prefix}/ install

    install -D -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/COPYING
}
