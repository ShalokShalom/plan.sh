pkg_origin=

pkg_name=google-talkplugin
pkg_version=5.41.3.0.1
_pkg_version=5.41.3.0-1
pkg_description="Video chat browser plug-in for Google Talk"
pkg_upstream_url="http://www.google.com/chat/video"
pkg_license=('unknown')
pkg_deps=('libgl' 'glew' 'glib2' 'libx11' 'libxfixes' 'libxt' 'openssl' 'gtk2')
optpkg_deps=('libnotify' 'pulseaudio')
pkg_shasum=('03ea81590baa680d286d28533c4d40e1'
         '2fc8d2491008850e6f83874f2716257f')
# version at #https://dl.google.com/linux/talkplugin/deb/dists/stable/main/binary-i386/Packages
pkg_source=("https://dl.google.com/linux/talkplugin/deb/pool/main/g/google-talkplugin/google-talkplugin_${_pkg_version}_amd64.deb"
        'license.html')

do_package() {
    msg "Extracting..."
    ar -xv google-talkplugin_${_pkg_version}_amd64.deb
    tar -xvf data.tar.gz
    msg2 "Done extracting!"
    msg "Moving files"
    mv $CACHE_PATH/opt $pkg_prefix
    mv $CACHE_PATH/usr $pkg_prefix
    msg2 "Done moving files"
    
    install -Dm644 "${CACHE_PATH}/license.html" "${pkg_prefix}/usr/share/licenses/${pkg_name}/license.html"
}
