pkg_origin=cosmos

pkg_name=ctemplate
pkg_version=2.3
pkg_description='Template system that leans strongly towards preserving the separation of logic and presentation.'
pkg_upstream_url='https://github.com/olafvdspek/ctemplate'
pkg_license=('BSD')
pkg_deps=('gcc-libs' 'perl')
pkg_build_deps=('python2')
pkg_source=("https://github.com/OlafvdSpek/ctemplate/archive/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('3b91f3c1e7aa55cb4c2957acf77d6b9a')

do_build() {

    ./configure --prefix=/usr
    make
}

do_package() {
    make DESTDIR=${pkg_prefix} install

    install -D -m0644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
