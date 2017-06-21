pkg_origin=cosmos

pkg_name=xorg-fonts-misc
pkg_version=1.0.3
pkg_description="X.org misc fonts"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('xorg-fonts-encodings' 'xorg-fonts-alias' 'xorg-font-utils' 'fontconfig')
install=xfonts.install
pkg_source=("https://xorg.freedesktop.org/releases/individual/font/font-arabic-misc-${pkg_version}.tar.bz2"
        "https://xorg.freedesktop.org/releases/individual/font/font-cursor-misc-${pkg_version}.tar.bz2"
        "https://xorg.freedesktop.org/releases/individual/font/font-daewoo-misc-${pkg_version}.tar.bz2"
        "https://xorg.freedesktop.org/releases/individual/font/font-dec-misc-${pkg_version}.tar.bz2"
        "https://xorg.freedesktop.org/releases/individual/font/font-isas-misc-${pkg_version}.tar.bz2"
        "https://xorg.freedesktop.org/releases/individual/font/font-jis-misc-${pkg_version}.tar.bz2"
        "https://xorg.freedesktop.org/releases/individual/font/font-micro-misc-${pkg_version}.tar.bz2"
        "https://xorg.freedesktop.org/releases/individual/font/font-misc-misc-1.1.2.tar.bz2"
        "https://xorg.freedesktop.org/releases/individual/font/font-mutt-misc-${pkg_version}.tar.bz2"
        "https://xorg.freedesktop.org/releases/individual/font/font-schumacher-misc-1.1.2.tar.bz2"
        "https://xorg.freedesktop.org/releases/individual/font/font-sony-misc-${pkg_version}.tar.bz2"
        "https://xorg.freedesktop.org/releases/individual/font/font-sun-misc-${pkg_version}.tar.bz2")
pkg_shasum=('cc0726e4a277d6ed93b8e09c1f195470'
         '3e0069d4f178a399cffe56daa95c2b63'
         '0571bf77f8fab465a5454569d9989506'
         '6e7c5108f1b16d7a1c7b2c9760edd6e5'
         'a2401caccbdcf5698e001784dbd43f1a'
         'cb7b57d7800fd9e28ec35d85761ed278'
         '143c228286fe9c920ab60e47c1b60b67'
         'c88eb44b3b903d79fb44b860a213e623'
         '56b0296e8862fc1df5cdbb4efe604e86'
         'e805feb7c4f20e6bfb1118d19d972219'
         'beef61a9b0762aba8af7b736bb961f86'
         '948f2e07810b4f31195185921470f68d')

do_build() {
  
  for dir in *; do
    if [ -d ${dir} ]; then
      pushd ${dir}
      ./configure --prefix=/usr \
          --with-fontdir=/usr/share/fonts/misc
      make
      popd
    fi
  done
}

do_package() {
  install -m755 -d ${CACHE_PATH}/usr/share/licenses/${pkg_name}
  
  for dir in *; do
    if [ -d ${dir} ]; then
      pushd ${dir}
      make DESTDIR=${CACHE_PATH} install
      install -m644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE.${dir%-*}
      popd
    fi
  done
  
  rm -f ${CACHE_PATH}/usr/share/fonts/*/fonts.*
}
