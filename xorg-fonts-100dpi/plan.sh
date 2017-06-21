pkg_origin=cosmos

pkg_name=xorg-fonts-100dpi
pkg_version=1.0.3
pkg_description="X.org 100dpi fonts"
pkg_upstream_url="https://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('xorg-fonts-encodings' 'xorg-fonts-alias' 'xorg-font-utils' 'fontconfig')
groups=('xorg')
install=xfonts.install
pkg_source=("https://xorg.freedesktop.org/releases/individual/font/font-adobe-100dpi-1.0.3.tar.bz2"
        "https://xorg.freedesktop.org/releases/individual/font/font-adobe-utopia-100dpi-1.0.4.tar.bz2"
        "https://xorg.freedesktop.org/releases/individual/font/font-bh-100dpi-1.0.3.tar.bz2"
        "https://xorg.freedesktop.org/releases/individual/font/font-bh-lucidatypewriter-100dpi-1.0.3.tar.bz2"
        "https://xorg.freedesktop.org/releases/individual/font/font-bitstream-100dpi-1.0.3.tar.bz2")
pkg_shasum=('1347c3031b74c9e91dc4dfa53b12f143'
         '66fb6de561648a6dce2755621d6aea17'
         '9f11ade089d689b9d59e0f47d26f39cd'
         'c8b73a53dcefe3e8d3907d3500e484a9'
         '6b223a54b15ecbd5a1bc52312ad790d8')

do_build() {
  
  for dir in font-*-100dpi*; do
    if [ -d ${dir} ]; then
      pushd ${dir}
      ./configure --prefix=/usr \
          --with-fontdir=/usr/share/fonts/100dpi
      make
      popd
    fi
  done
}

do_package() {
  install -m755 -d ${CACHE_PATH}/usr/share/licenses/${pkg_name}
  
  for dir in font-*-100dpi*; do
    if [ -d ${dir} ]; then
      pushd ${dir}
      make DESTDIR=${CACHE_PATH} install
      install -m644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE.${dir%-100dpi-*}
      popd
    fi
  done
  
  rm -f ${CACHE_PATH}/usr/share/fonts/100dpi/fonts.*
}
