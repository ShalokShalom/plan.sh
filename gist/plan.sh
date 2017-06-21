pkg_origin=

pkg_name=gist
pkg_version=4.6.1
pkg_description="Provides a gist command to use from the terminal to upload content to https://gist.github.com/."
pkg_upstream_url="http://github.com/defunkt/gist"
pkg_license=('MIT')
pkg_deps=('ruby')
pkg_source=("https://github.com/defunkt/${pkg_name}/archive/v${pkg_version}.tar.gz")
pkg_shasum=('3b89929d739780a9109fff20f7df9b7e')

do_package() {
    cd ${pkg_name}-${pkg_version}

    install -Dm755 build/${pkg_name} ${pkg_prefix}/usr/bin/${pkg_name}
    install -Dm644 build/${pkg_name}.1 ${pkg_prefix}/usr/share/man/man1/${pkg_name}.1
    install -Dm644 LICENSE.MIT ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
