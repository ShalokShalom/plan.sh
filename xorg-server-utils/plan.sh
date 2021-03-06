pkg_origin=cosmos

pkg_name=xorg-server-utils
pkg_version=7.11
pkg_description="X.Org utilities required by xorg-server"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('libxfontcache' 'libxi' 'libxaw' 'libxrandr' 'libxxf86vm' 'mcpp'
         'xcb-util' 'libxinerama' 'libxcursor')
pkg_build_deps=('pkgconfig' 'xbitmaps' 'bigreqsproto' 'xtrans' 'xorg-util-macros')
groups=('xorg')
pkg_source=("http://xorg.freedesktop.org/releases/individual/app/iceauth-1.0.7.tar.bz2"
        "${url}/releases/individual/app/rgb-1.0.6.tar.bz2"
        "${url}/releases/individual/app/sessreg-1.1.1.tar.bz2"
        "${url}/releases/individual/app/xcmsdb-1.0.5.tar.bz2"
        "${url}/releases/individual/app/xbacklight-1.2.1.tar.bz2"
        "${url}/releases/individual/app/xgamma-1.0.6.tar.bz2"
        "${url}/releases/individual/app/xhost-1.0.7.tar.bz2"
        "${url}/releases/individual/app/xinput-1.6.2.tar.bz2"
        "${url}/releases/individual/app/xmodmap-1.0.9.tar.bz2"
        "${url}/releases/individual/app/xrandr-1.5.0.tar.bz2"
        "${url}/releases/individual/app/xrdb-1.1.0.tar.bz2"
        "${url}/releases/individual/app/xrefresh-1.0.5.tar.bz2"
        "${url}/releases/individual/app/xset-1.2.3.tar.bz2"
        "${url}/releases/individual/app/xsetmode-1.0.0.tar.bz2"
        "${url}/releases/individual/app/xsetroot-1.1.1.tar.bz2"
        "${url}/releases/individual/app/xvidtune-1.0.3.tar.bz2"
        'LICENSE.iceauth'
        'LICENSE.xcmsdb'
        'LICENSE.xvidtune')
pkg_shasum=('25dab02f8e40d5b71ce29a07dc901b8c'
         'eab5bbd7642e5c784429307ec210d198'
         'e475167a892b589da23edf8edf8c942d'
         '9956d751ea3ae4538c3ebd07f70736a0'
         '0066f23f69ca3ef62dcaeb74a87fdc48'
         '90b4305157c2b966d5180e2ee61262be'
         'f5d490738b148cb7f2fe760f40f92516'
         '6a889412eff2e3c1c6bb19146f6fe84c'
         '723f02d3a5f98450554556205f0a9497'
         'ebffac98021b8f1dc71da0c1918e9b57'
         'b54c7e3e53b4f332d41ed435433fbda0'
         'a896382bc53ef3e149eaf9b13bc81d42'
         'dcd227388b57487d543cab2fd7a602d7'
         'd074e79d380b031d2f60e4cd56538c93'
         '7211b31ec70631829ebae9460999aa0b'
         '8676c9bb1658fe91de244e850f6c3ca8'
         '65695dc24c24958190724a23655ffda7'
         'b6235416dca2205f0ba83c0c4b3ddeb8'
         '4e6babde6334e3c5cb4a3136526aa564')

do_build() {
  
  for i in *; do
    if [ -d "${i}" ]; then
      pushd "${i}"
      case "${i}" in
        xrdb*)
          ./configure --prefix=/usr --mandir=/usr/share/man --with-cpp=/usr/bin/mcpp 
          ;;
        *)
          ./configure --prefix=/usr --mandir=/usr/share/man
          ;;
      esac
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
      install -m755 -d "${CACHE_PATH}/usr/share/licenses/${pkg_name}"
      install -m644 COPYING "${CACHE_PATH}"/usr/share/licenses/${pkg_name}/LICENSE.${i%-*}
      popd
    fi
  done

  # Replacing stub license files
  install -m644 "${CACHE_PATH}"/LICENSE.* "${CACHE_PATH}/usr/share/licenses/${pkg_name}/"
}
