pkg_origin=cosmos

pkg_name=xorg-xkb-utils
pkg_version=7.7
pkg_description="X.org keyboard utilities"
pkg_upstream_url="https://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('libxaw>=1.0.12' 'libxkbfile')
pkg_build_deps=('pkgconfig' 'inputproto')
pkg_source=("https://xorg.freedesktop.org/releases/individual/app/xkbutils-1.0.4.tar.bz2"
        "https://xorg.freedesktop.org/releases/individual/app/xkbcomp-1.4.0.tar.bz2"
        "https://xorg.freedesktop.org/releases/individual/app/xkbevd-1.1.4.tar.bz2"
        "https://xorg.freedesktop.org/releases/individual/app/setxkbmap-1.3.1.tar.bz2"
        "https://xorg.freedesktop.org/releases/individual/app/xkbprint-1.0.4.tar.bz2"
        'LICENSE.setxkbmap' 'LICENSE.xkbevd' 'LICENSE.xkbutils')
pkg_shasum=('502b14843f610af977dffc6cbf2102d5'
         'cc22b232bc78a303371983e1b48794ab'
         'c747faf1f78f5a5962419f8bdd066501'
         '2c47a1b8e268df73963c4eb2316b1a89'
         '3c25b40de530112c08bf7d229c5c6a28'
         '7c20baa6a26c32a04b1b1d6cbaa626a7'
         '7b1fc39455375a25afe6f9594ff979ac'
         '7b1fc39455375a25afe6f9594ff979ac')

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
  # Replacing stub license files
  install -D -m644 "${CACHE_PATH}"/LICENSE.* "${CACHE_PATH}/usr/share/licenses/${pkg_name}/" 
}
