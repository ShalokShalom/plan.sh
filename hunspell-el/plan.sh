pkg_origin=cosmos

pkg_name=hunspell-el
pkg_version=0.9
pkg_description="Greek hunspell dictionary"
pkg_upstream_url="http://elspell.math.upatras.gr"
pkg_license=('MPL' 'GPL' 'LGPL')
pkg_deps=('hunspell')
pkg_source=("http://elspell.math.upatras.gr/files/ooffice/el_GR-${pkg_version}.zip")
pkg_shasum=('5b1ff7b3bc8203488b7d6f21fa875743')

do_package() {
    install -dm755 ${pkg_prefix}/usr/share/hunspell
    install -m644 el_GR.aff ${pkg_prefix}/usr/share/hunspell
    install -m644 el_GR.dic ${pkg_prefix}/usr/share/hunspell

    install -dm755 ${pkg_prefix}/usr/share/myspell/dicts
    pushd ${pkg_prefix}/usr/share/myspell/dicts
    for file in ${pkg_prefix}/usr/share/hunspell/*; do
        ln -sv /usr/share/hunspell/$(basename ${file}) .
    done
    popd

    install -Dm644 README_el_GR.txt ${pkg_prefix}/usr/share/doc/${pkg_name}
}
