pkg_origin=cosmos

pkg_name=xorg-fonts-cyrillic
pkg_version=1.0.3
pkg_description="X.org cyrillic fonts"
pkg_upstream_url="https://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('xorg-fonts-encodings' 'xorg-fonts-alias' 'xorg-font-utils' 'fontconfig')
install=xfonts.install
pkg_source=("https://xorg.freedesktop.org/releases/individual/font/font-cronyx-cyrillic-${pkg_version}.tar.bz2"
        "https://xorg.freedesktop.org/releases/individual/font/font-misc-cyrillic-${pkg_version}.tar.bz2"
        "https://xorg.freedesktop.org/releases/individual/font/font-screen-cyrillic-1.0.4.tar.bz2"
        "https://xorg.freedesktop.org/releases/individual/font/font-winitzki-cyrillic-${pkg_version}.tar.bz2")
pkg_shasum=('e452b94b59b9cfd49110bb49b6267fba'
         '96109d0890ad2b6b0e948525ebb0aba8'
         '6f3fdcf2454bf08128a651914b7948ca'
         '829a3159389b7f96f629e5388bfee67b')

do_build() {
  
  for dir in *; do
    if [ -d ${dir} ]; then
      pushd ${dir}
      ./configure --prefix=/usr --with-fontdir=/usr/share/fonts/cyrillic
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
