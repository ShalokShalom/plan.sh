pkg_origin=cosmos

pkg_name=ttf-indic-otf
pkg_version=0.2
pkg_description="A set of free high-quality TrueType fonts covering for every official Indian language"
pkg_upstream_url="http://www.indlinux.org/wiki/index.php/Downloads"
pkg_license=('GPL')
pkg_deps=('xorg-fonts-encodings' 'xorg-fonts-alias' 'xorg-font-utils' 'fontconfig')
install=ttf-indic-otf.install
pkg_source=("http://www.indlinux.org/downloads/files/indic-otf-${pkg_version}.tar.gz")
pkg_shasum=('d50bb65a39d78608be3560f38f003d21')

do_package() {
        
    install -d ${CACHE_PATH}/usr/share/fonts/TTF
    install -m644 *.ttf ${CACHE_PATH}/usr/share/fonts/TTF
}
