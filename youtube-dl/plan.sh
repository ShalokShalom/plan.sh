pkg_origin=cosmos

pkg_name=youtube-dl
pkg_version=2017.06.18
pkg_description='Small command-line program to download videos from YouTube.com and other video sites'
pkg_upstream_url="http://rg3.github.com/youtube-dl"
pkg_license=('custom')
pkg_deps=('python3')
pkg_build_deps=('zip')
pkg_source=("https://github.com/rg3/youtube-dl/releases/download/${pkg_version}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('d7234bcdb02077906a8d3a0e4c6006d6')

do_build() {
    sed -i 's|python|python3|g' Makefile
    #sed -i 's|youtube-dl README.md CONTRIBUTING.md README.txt youtube-dl.1|youtube-dl |g' Makefile
    #sed -i 's|youtube-dl youtube-dl.1|youtube-dl |g' Makefile
    
    make
}

do_package() {
    make PREFIX=/usr SYSCONFDIR=/usr/share MANDIR=/usr/share/man DESTDIR=${CACHE_PATH} install

    install -D -m644 LICENSE ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
