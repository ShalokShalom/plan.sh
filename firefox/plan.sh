pkg_origin=

pkg_name=firefox
pkg_description='Standalone web browser from mozilla.org'
pkg_upstream_url='http://www.mozilla.org/projects/firefox'
pkg_version=54.0
pkg_license=('MPL' 'GPL' 'LGPL')
#install=firefox.install
pkg_deps=('desktop-file-utils' 'libxt' 'mime-types' 'nss' 'shared-mime-info' 'gtk2' 'gtk3' 'networkmanager'
         'gst-plugins-good' 'gst-plugins-bad' 'gst-libav' 'mozilla-common' 'startup-notification'
         'dbus-glib' 'alsa-lib' 'hicolor-icon-theme' 'libvpx' 'icu' 'libevent' 'sqlite' 'hunspell'
         'pulseaudio')
pkg_build_deps=('unzip' 'zip' 'diffutils' 'python2' 'yasm' 'mesa' 'imake' 'xorg-server' 
             'inetutils' 'gconf' 'autoconf2.13' 'rust' 'cargo')
optpkg_deps=('freshplayerplugin: full flash support in firefox')
pkg_source=("https://ftp.mozilla.org/pub/mozilla.org/firefox/releases/${pkg_version}/source/firefox-${pkg_version}.source.tar.xz"
        'mozconfig'
        'firefox.desktop'
        'firefox-install-dir.patch'
        'vendor.js')
pkg_shasum=('bd9eccc20354ad3e69e0265f0a7f5c90'
         '53a591ec885cf81b720a30ea9b8acf9e'
         '174a2a286e32d5c9a48f51a18ffa4e6c'
         'dbf14588e85812ee769bd735823a0146'
         '0d053487907de4376d67d8f499c5502b')

do_prepare() {
  cd ${pkg_name}-${pkg_version}

  cp ../mozconfig .mozconfig
  patch -p1 -i ${CACHE_PATH}/firefox-install-dir.patch

  mkdir ${CACHE_PATH}/path
  
  #sed -i '/ac_cpp=/s/$CPPFLAGS/& -O2/' configure
}

do_build() {
  cd ${pkg_name}-${pkg_version}

  export PATH=${CACHE_PATH}/path:$PATH
  unset CPPFLAGS

  make -f client.mk build # MOZ_PGO=0
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make -f client.mk DESTDIR=${pkg_prefix} INSTALL_SDK= install

  install -Dm644 ../vendor.js ${pkg_prefix}/usr/lib/firefox/browser/defaults/preferences/vendor.js

  for i in 16 22 24 32 48 256; do
      install -Dm644 browser/branding/official/default$i.png \
        ${pkg_prefix}/usr/share/icons/hicolor/${i}x${i}/apps/firefox.png
  done
  install -Dm644 browser/branding/official/content/icon64.png ${pkg_prefix}/usr/share/icons/hicolor/64x64/apps/firefox.png
  install -Dm644 browser/branding/official/mozicon128.png ${pkg_prefix}/usr/share/icons/hicolor/128x128/apps/firefox.png
  install -Dm644 browser/branding/official/content/about-logo.png ${pkg_prefix}/usr/share/icons/hicolor/192x192/apps/firefox.png
  install -Dm644 browser/branding/official/content/about-logo@2x.png ${pkg_prefix}/usr/share/icons/hicolor/384x384/apps/firefox.png

  install -Dm644 ../firefox.desktop ${pkg_prefix}/usr/share/applications/firefox.desktop

  ln -sf firefox ${pkg_prefix}/usr/lib/firefox/firefox-bin
}
