pkg_origin=

pkg_name=minilens
pkg_version=1.2
pkg_description="2D platform puzzle in post-apocalyptic Earth"
pkg_upstream_url="http://kobuge-games.github.io/minilens/"
pkg_license=('MIT')
pkg_deps=('godot')
pkg_source=("https://github.com/KOBUGE-Games/minilens/archive/v${pkg_version}.tar.gz"
        'minilens.desktop'
        'launch-minilens.sh')
pkg_shasum=('ea80ca7a715acd0766a4bb18a004ea15'
         '7050c7a01dc42fb63486ffbcd6f09164'
         'aeb7be1b3f976e38939cd09b54992b1a')

do_package() {
    cd ${pkg_name}-${pkg_version}
    
    install -d ${pkg_prefix}/opt/minilens
    cp -r * ${pkg_prefix}/opt/minilens/
    chmod 755 -R ${pkg_prefix}/opt/minilens
    
    install -Dm755 ${CACHE_PATH}/launch-minilens.sh ${pkg_prefix}/usr/bin/launch-minilens.sh
    install -Dm644 $CACHE_PATH/minilens.desktop ${pkg_prefix}/usr/share/applications/minilens.desktop
    install -Dm644 ${CACHE_PATH}/${pkg_name}-${pkg_version}/icon.png ${pkg_prefix}/usr/share/pixmaps/minilens.png
}
