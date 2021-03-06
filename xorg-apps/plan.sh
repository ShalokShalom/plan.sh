pkg_origin=cosmos

pkg_name=xorg-apps
pkg_version=7.10
pkg_description="Various X.Org applications"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('libxcursor' 'libxkbfile' 'libpng' 'libxft' 'libfontenc' 'libxaw')
pkg_build_deps=('pkgconfig' 'xbitmaps' 'xorg-util-macros')
pkg_source=("http://xorg.freedesktop.org/releases/individual/app/oclock-1.0.3.tar.bz2"
        "${url}/releases/individual/app/luit-1.1.1.tar.bz2"
        "${url}/releases/individual/app/xclock-1.0.7.tar.bz2"
        "${url}/releases/individual/app/xpr-1.0.4.tar.bz2"
        "${url}/releases/individual/app/xwd-1.0.6.tar.bz2"
        "${url}/releases/individual/app/xwud-1.0.4.tar.bz2"
        "${url}/releases/individual/app/x11perf-1.6.0.tar.bz2"
        "${url}/releases/individual/app/xbiff-1.0.3.tar.bz2"
        "${url}/releases/individual/app/xclipboard-1.1.3.tar.bz2"
        "${url}/releases/individual/app/xconsole-1.0.7.tar.bz2"
        "${url}/releases/individual/app/xcursorgen-1.0.6.tar.bz2"
        "${url}/releases/individual/app/xeyes-1.1.1.tar.bz2"
        "${url}/releases/individual/app/xkill-1.0.4.tar.bz2"
        "${url}/releases/individual/app/xload-1.1.2.tar.bz2"
        "${url}/releases/individual/app/xlogo-1.0.4.tar.bz2"
        "${url}/releases/individual/app/xmag-1.0.6.tar.bz2"
        "${url}/releases/individual/app/xmessage-1.0.4.tar.bz2"
        "${url}/releases/individual/app/xcalc-1.0.6.tar.bz2"
        "${url}/releases/individual/app/xman-1.1.4.tar.bz2"
        "${url}/releases/individual/app/xedit-1.2.2.tar.bz2"
        'LICENSE'
        'luit.patch')
pkg_shasum=('f73ad0fa3fda1efe1036e1f48f8a3953'
         'c4a3664e08e5a47c120ff9263ee2f20c'
         '6f150d063b20d08030b98c45b9bee7af'
         '6101f04731ffd40803df80eca274ec4b'
         '6b5d48464c5f366e91efd08b62b12d94'
         '3025b152b4f13fdffd0c46d0be587be6'
         'f0b24e4d8beb622a419e8431e1c03cd7'
         'f38a0c63c2a7ed6fb9d6f8884785b5c9'
         '3facff108f65b0733b04becf20274e45'
         '5c42e161fcd4289a463366e17683598a'
         'b58a87e6cd7145c70346adad551dba48'
         'a3035dcecdbdb89e864177c080924981'
         '0ae6bc2a8d3af68e9c76b1a6ca5f7a78'
         'b9e9808db18acecf4cdec134d86b157c'
         '4ce21861f7b9398805beba8b62d8ff8e'
         '8aaa41374935d697ee55d7dc9de70781'
         '2dd5ae46fa18abc9331bc26250a25005'
         '397584a68bfe6b02adff16e67f8fe5dd'
         'f9ac24d44ccdd6978d3a2c57e8746a8a'
         '74ee6db901e81978b087b2026d8f30a0'
         '1a3977bcff6dc0fc1086e0650fcea31a'
         '409804b977724ab48d847df466be1b55')

do_build() {
  patch -p0 -i $CACHE_PATH/luit.patch
  
  for i in *; do
    if [ -d "${i}" ]; then
      pushd "${i}"
      # remove disable error on luit fix upstream
      ./configure --prefix=/usr --mandir=/usr/share/man --disable-selective-werror
      make
      popd
    fi
  done
}

do_package() {
  
  for i in *; do
    if [ -d "${i}" ]; then
      pushd "${i}"    
      make DESTDIR="${CACHE_PATH}" install
      popd
    fi
  done
  
  install -D -m644 LICENSE "${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE"
}

