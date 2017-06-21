pkg_origin=

pkg_name=thunderbird
pkg_version=52.2.0
pkg_description="Standalone Mail/News reader"
pkg_license=('MPL' 'GPL' 'LGPL')
pkg_upstream_url="https://www.mozilla.org/thunderbird"
pkg_deps=('alsa-lib' 'cairo' 'dbus-glib' 'desktop-file-utils' 'fontconfig' 'freetype2'
         'gtk3' 'hicolor-icon-theme' 'hunspell' 'libevent' 'libjpeg' 'libmng' 'libpng'
         'libvpx' 'libxt' 'mozilla-common' 'nspr' 'nss' 'shared-mime-info' 'sqlite'
         'startup-notification' 'libcanberra')
pkg_source=("https://ftp.mozilla.org/pub/mozilla.org/thunderbird/releases/${pkg_version}/linux-x86_64/en-US/thunderbird-${pkg_version}.tar.bz2"
        'thunderbird.desktop'
        'vendor.js')
pkg_shasum=('dbae48ec456769ee0e8b578b2c2b1516'
         '81da98196b2004e539eba80b8fd4d0fd'
         '5a53179d14ae9631b7afe5e4d0fc0b25')

do_package() {
  install -d ${pkg_prefix}/{usr/bin,opt}

  cp -r thunderbird/ ${pkg_prefix}/opt/$pkg_name-$pkg_version/
  cp vendor.js ${pkg_prefix}/opt/$pkg_name-$pkg_version/defaults/pref/
  
  ln -s /opt/$pkg_name-$pkg_version/thunderbird ${pkg_prefix}/usr/bin/thunderbird
  
  for i in 16x16 22x22 24x24 32x32 48x48 256x256; do
      install -Dm644 thunderbird/chrome/icons/default/default${i/x*/}.png ${pkg_prefix}/usr/share/icons/hicolor/$i/apps/thunderbird.png
  done
  
  install -Dm644 thunderbird.desktop ${pkg_prefix}/usr/share/applications/thunderbird.desktop
  
  rm -rf ${pkg_prefix}/opt/$pkg_name-$pkg_version/dictionaries/
  ln -sf /usr/share/hunspell/ ${pkg_prefix}/opt/$pkg_name-$pkg_version/dictionaries
  ln -sf /usr/share/hyphen/ ${pkg_prefix}/opt/$pkg_name-$pkg_version/hyphenation
}
