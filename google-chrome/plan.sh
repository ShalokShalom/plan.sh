pkg_origin=

pkgbase=google-chrome
pkg_name=('google-chrome' 'widevine')
pkg_version=61.0.3128.3
pkg_upstream_url="http://dev.chromium.org/getting-involved/dev-channel"
pkg_license=('custom:chrome')
pkg_build_deps=('gcc-libs' 'gtk3' 'nss' 'gconf' 'libjpeg-turbo' 'freetype2' 'cairo' 'libxslt'
            'libpng' 'alsa-lib' 'libxss' 'hicolor-icon-theme' 'xdg-utils')
# version:  curl -s https://dl.google.com/linux/chrome/rpm/stable/x86_64/repodata/other.xml.gz | gzip -df | awk -F\" '/pkgid/{ sub(".*-","",$4); print $4": "$10 }'
pkg_source=("google-chrome-unstable_${pkg_version}_amd64.deb::https://dl.google.com/linux/direct/google-chrome-unstable_current_amd64.deb"
         "https://www.google.com/chrome/intl/en/eula_text.html"
         'google-chrome-unstable.desktop')
pkg_shasum=('b95dd4081fdd084602da8a4e5df68c2d'
         'd50d8f0a6940791eabc41c4f64e6a3cf'
         'dc490bcda18c1379056700057800cc8f')


package_google-chrome() {
    pkg_description="Google Chrome Browser, developer preview channel for Linux"
    pkg_deps=('gcc-libs' 'gtk3' 'nss' 'gconf' 'libjpeg-turbo' 'freetype2' 'cairo' 'libxslt'
             'libpng' 'alsa-lib' 'libxss' 'hicolor-icon-theme' 'xdg-utils' 'widevine')
    groups=('network')
    install=$pkg_name.install
    
    bsdtar -xf data.tar.xz -C ${pkg_prefix}/ 

    # Adding man page
    gzip ${pkg_prefix}/usr/share/man/man1/google-chrome-unstable.1
    
    # icons to /usr/share/icons/hicolor/ too
    for i in 16 22 24 32 48 64 128 256; do
    install -Dm644 ${pkg_prefix}/opt/google/chrome-unstable/product_logo_${i}.png ${pkg_prefix}/usr/share/icons/hicolor/${i}x${i}/apps/google-chrome.png
    done

    # License
    install -Dm644 $CACHE_PATH/eula_text.html ${pkg_prefix}/usr/share/licenses/google-chrome/eula_text.html
    
    rm -r ${pkg_prefix}/etc/cron.daily/ ${pkg_prefix}/opt/google/chrome-unstable/cron/
    rm ${pkg_prefix}/opt/google/chrome-unstable/product_logo_*.png
    
    # use in widevine package
    rm ${pkg_prefix}/opt/google/chrome-unstable/libwidevinecdm.so
    rm ${pkg_prefix}/opt/google/chrome-unstable/libwidevinecdmadapter.so
    
    rm ${pkg_prefix}/usr/share/applications/google-chrome-unstable.desktop
    install -m755 $CACHE_PATH/google-chrome-unstable.desktop ${pkg_prefix}/usr/share/applications/google-chrome-unstable.desktop
    # symlink no longer provided, back with 55
    #ln -s /opt/google/chrome-unstable/google-chrome-unstable ${pkg_prefix}/usr/bin/google-chrome-unstable
}

package_widevine() {
    pkg_description="Google Chrome's plugin for viewing premium video content"
    pkg_deps=('pulseaudio')
    
    bsdtar -xf data.tar.xz
    
    install -Dm644 opt/google/chrome-unstable/libwidevinecdm.so ${pkg_prefix}/opt/google/chrome-unstable/libwidevinecdm.so
    install -Dm755 opt/google/chrome-unstable/libwidevinecdmadapter.so ${pkg_prefix}/opt/google/chrome-unstable/libwidevinecdmadapter.so
    
    mkdir -p ${pkg_prefix}/usr/lib/chromium
    cd ${pkg_prefix}
    ln -s /opt/google/chrome-unstable/libwidevinecdm.so ${pkg_prefix}/usr/lib/chromium/libwidevinecdm.so
    ln -s /opt/google/chrome-unstable/libwidevinecdmadapter.so ${pkg_prefix}/usr/lib/chromium/libwidevinecdmadapter.so
    
    install -Dm644 $CACHE_PATH/eula_text.html ${pkg_prefix}/usr/share/licenses/widevine/eula_text.html
}
