pkg_origin=cosmos

pkg_name=xorg-fonts-75dpi
pkg_version=1.0.3
pkg_description="X.org 75dpi fonts"
pkg_upstream_url="https://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('xorg-fonts-encodings' 'xorg-fonts-alias' 'xorg-font-utils' 'fontconfig')
groups=('xorg')
install=xfonts.install
pkg_source=("https://xorg.freedesktop.org/releases/individual/font/font-adobe-75dpi-1.0.3.tar.bz2"
        "https://xorg.freedesktop.org/releases/individual/font/font-adobe-utopia-75dpi-1.0.4.tar.bz2"
        "https://xorg.freedesktop.org/releases/individual/font/font-bh-75dpi-1.0.3.tar.bz2"
        "https://xorg.freedesktop.org/releases/individual/font/font-bh-lucidatypewriter-75dpi-1.0.3.tar.bz2"
        "https://xorg.freedesktop.org/releases/individual/font/font-bitstream-75dpi-1.0.3.tar.bz2")
pkg_shasum=('6c9f26c92393c0756f3e8d614713495b'
         'e99276db3e7cef6dccc8a57bc68aeba7'
         '565494fc3b6ac08010201d79c677a7a7'
         'f6d65758ac9eb576ae49ab24c5e9019a'
         'd7c0588c26fac055c0dd683fdd65ac34')

do_build() {
  
  for dir in *; do
    if [ -d ${dir} ]; then
      pushd ${dir}
      ./configure --prefix=/usr \
          --with-fontdir=/usr/share/fonts/75dpi
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
      install -m644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE.${dir%-75dpi-*}
      popd
    fi
  done
  
  rm -f ${CACHE_PATH}/usr/share/fonts/75dpi/fonts.*
}
