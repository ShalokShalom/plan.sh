pkg_origin=

pkg_name=pepper-flash
_licensefile='PlatformClients_PC_WWEULA-en_US-20150407_1357.pdf'
pkg_version=26.0.0.131
pkg_description='Adobe Flash Player - Chromium based browsers version'
pkg_upstream_url='https://get.adobe.com/flashplayer/?no_redirect'
pkg_deps=('pulseaudio')
optpkg_deps=('freshplayerplugin: required for flash support in Firefox')
install=$pkg_name.install
pkg_license=('custom')
pkg_source=("https://fpdownload.adobe.com/pub/flashplayer/pdc/${pkg_version}/flash_player_ppapi_linux.x86_64.tar.gz"
        "https://wwwimages2.adobe.com/www.adobe.com/content/dam/Adobe/en/legal/licenses-terms/pdf/${_licensefile}")
pkg_shasum=('abbf65cb5fa90190f54d0b08aa7ab06a'
         '519cae27f11d267b31084c1eee5fb6b0')

package () {
    install -Dm644 manifest.json ${pkg_prefix}/usr/lib/PepperFlash/manifest.json
    install -Dm755 libpepflashplayer.so ${pkg_prefix}/usr/lib/PepperFlash/libpepflashplayer.so
    
    install -Dm644 ${_licensefile} ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE.pdf
}
