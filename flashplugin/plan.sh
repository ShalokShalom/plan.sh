pkg_origin=

pkg_name=flashplugin
_licensefile='PlatformClients_PC_WWEULA-en_US-20150407_1357.pdf'
pkg_version=23.0.0.173
pkg_description='Adobe Flash Player'
pkg_upstream_url='http://labs.adobe.com/technologies/flashplatformruntimes/'
pkg_deps=('mozilla-common' 'libxt' 'libxpm' 'nss' 'curl' 'gtk2')
optpkg_deps=('libvdpau: GPU acceleration on Nvidia card')
pkg_license=('custom')
backup=('etc/adobe/mms.cfg')
pkg_source=("https://fpdownload.macromedia.com/pub/labs/flashruntimes/flashplayer/linux64/libflashplayer.so"
        "https://wwwimages2.adobe.com/www.adobe.com/content/dam/Adobe/en/legal/licenses-terms/pdf/${_licensefile}"
        'mms.cfg')
pkg_shasum=('24c8c35fb0d72c11cfa19e7997007e9b'
         '94ca2aecb409abfe36494d1a7ec7591d'
         'dcd4454dc4aa8116b4d7a6c3ba159ea4')

package () {
    install -Dm755 libflashplayer.so ${pkg_prefix}/usr/lib/mozilla/plugins/libflashplayer.so
    
    install -Dm644 ${_licensefile} ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE.pdf
    install -Dm644 ${CACHE_PATH}/mms.cfg ${pkg_prefix}/etc/adobe/mms.cfg
}

