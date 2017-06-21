pkg_origin=

pkg_name=godot
pkg_version=2.1.3
_pkg_version=2.1.3-stable
pkg_description="Full featured, open source, MIT licensed, game engine."
pkg_upstream_url="http://www.godotengine.org"
pkg_license=('MIT')
pkg_deps=('alsa-lib' 'glu' 'libx11' 'libxcursor' 'libxinerama' 'libxrandr' 'freetype2'
         'mesa' 'libwebp' 'pulseaudio' 'openssl')
pkg_build_deps=('scons')
pkg_source=("https://github.com/okamstudio/godot/archive/${_pkg_version}.tar.gz"
        'godot.desktop'
        'icon.png'
        "https://github.com/Faless/godot/commit/43bc27e2755f34017148097773da8a6988718aaf.diff")
pkg_shasum=('aa002bc480f461e25b740aae63e6069a'
         'dca7c5c5682bdc8cc83386034e0d7d07'
         'f756e85756a9cbc06a328414abf74585'
         '391f45e5dbbccd4258565a82b4aa4ed6')

do_build() {
    cd ${pkg_name}-${_pkg_version}
    # https://github.com/godotengine/godot/issues/7676
    #patch -p1 -i ${CACHE_PATH}/43bc27e2755f34017148097773da8a6988718aaf.diff

    scons platform=x11
}

do_package() {
    cd ${pkg_name}-${_pkg_version}
    
    install -Dm755 bin/godot.x11.tools.64 ${pkg_prefix}/usr/bin/godot

    install -Dm644 ../godot.desktop ${pkg_prefix}/usr/share/applications/godot.desktop
    install -Dm644 ../icon.png ${pkg_prefix}/usr/share/pixmaps/godot.png  
    install -Dm644 LICENSE.md ${pkg_prefix}/usr/share/licenses/godot/LICENSE.md
}

