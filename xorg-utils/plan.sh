pkg_origin=cosmos

pkg_name=xorg-utils
pkg_version=7.9
pkg_description="Collection of client utilities used to query the X server"
pkg_upstream_url="https://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('libxxf86dga' 'libxi' 'libxtst' 'libxinerama' 'libxv' 'libdmx' 'libxft' 'libxaw>=1.0.6'
         'libgl' 'libxcomposite' 'xorg-util-macros' 'xcb-util' 'libxrandr')
pkg_build_deps=('pkgconfig' 'mesa' 'glproto' 'xproto')
groups=('xorg')
pkg_source=("https://xorg.freedesktop.org//releases/individual/app/xdpyinfo-1.3.2.tar.bz2"
        "https://xorg.freedesktop.org//releases/individual/app/xdriinfo-1.0.5.tar.bz2"
        "https://xorg.freedesktop.org//releases/individual/app/xev-1.2.2.tar.bz2"
        "https://xorg.freedesktop.org//releases/individual/app/xfd-1.1.2.tar.bz2"
        "https://xorg.freedesktop.org//releases/individual/app/xfontsel-1.0.5.tar.bz2"
        "https://xorg.freedesktop.org//releases/individual/app/xlsatoms-1.1.2.tar.bz2"
        "https://xorg.freedesktop.org//releases/individual/app/xlsclients-1.1.3.tar.bz2"
        "https://xorg.freedesktop.org//releases/individual/app/xlsfonts-1.0.5.tar.bz2"
        "https://xorg.freedesktop.org//releases/individual/app/xprop-1.2.2.tar.bz2"
        "https://xorg.freedesktop.org//releases/individual/app/xvinfo-1.1.3.tar.bz2"
        "https://xorg.freedesktop.org//releases/individual/app/xwininfo-1.1.3.tar.bz2"
        'LICENSE.xdpyinfo' 'LICENSE.xfd' 'LICENSE.xlsclients' 
        'LICENSE.xprop' 'LICENSE.xwininfo' 'LICENSE.xev' 
        'LICENSE.xlsatoms' 'LICENSE.xlsfonts' 'LICENSE.xvinfo')
pkg_shasum=('8809037bd48599af55dad81c508b6b39'
         'fceddaeb08e32e027d12a71490665866'
         '249bdde90f01c0d861af52dc8fec379e'
         'f19de745d181f5547ed59d6d9ed7a588'
         'a40302b88c599b63e3d3d412e02871e6'
         '5dcb6e6c4b28c8d7aeb45257f5a72a7d'
         '9fbf6b174a5138a61738a42e707ad8f5'
         '6f5711bef8c765857a0887a91476283b'
         'fae3d2fda07684027a643ca783d595cc'
         '558360176b718dee3c39bc0648c0d10c'
         'b777bafb674555e48fd8437618270931'
         'b43f731a9e2684728230ce8e33f63228'
         '9e8a82b7e9898f36c378b80509f170a6'
         '9e8a82b7e9898f36c378b80509f170a6'
         '801f9850b29dad506e995d011efe2914'
         '1c47d00801594a0e251694d70c7fb0b8'
         'e84310edd65e120d85914350c795bfac'
         '9ee99bda91248e945186090905db25d8'
         '345d6e65d71fdde292cc27f93c15e4a1'
         '67ea6bb3b11620c82ce4d24e78b4a0a9')

do_build() {
  
  for i in *; do
    if [ -d "${i}" ]; then
      pushd "${i}"
      ./configure --prefix=/usr --mandir=/usr/share/man 
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
      install -D -m644 COPYING "${CACHE_PATH}"/usr/share/licenses/${pkg_name}/LICENSE.${i%-*} 
      popd
    fi
  done
  
  install -D -m644 LICENSE.* ${CACHE_PATH}/usr/share/licenses/${pkg_name}/  
}
