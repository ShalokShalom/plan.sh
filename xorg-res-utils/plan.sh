pkg_origin=cosmos

pkg_name=xorg-res-utils
pkg_version=1.0.6
pkg_description="X.Org X11 resource utilities"
pkg_upstream_url="https://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('libxaw')
pkg_build_deps=('pkgconfig')
groups=('xorg')
pkg_source=("https://xorg.freedesktop.org/releases/individual/app/appres-1.0.4.tar.bz2"
        "https://xorg.freedesktop.org/releases/individual/app/editres-1.0.6.tar.bz2"
        "https://xorg.freedesktop.org/releases/individual/app/listres-1.0.3.tar.bz2"
        "https://xorg.freedesktop.org/releases/individual/app/viewres-1.0.4.tar.bz2"
        'LICENSE.listres'
        'LICENSE.viewres')
pkg_shasum=('ed598f0599d726963c1bdfdc691960d9'
         '623322610e4040393e0ff2a69e6612cd'
         '4e8edcc03001203c101e79d880d55762'
         'e4651e55dccb0ae234e49bdc0b984fc9'
         '9c9b17ae5e9be0c570dabe9e54f54f6d'
         '9c9b17ae5e9be0c570dabe9e54f54f6d')

do_build() {
  
  for i in *; do
    if [ -d ${i} ]; then
      pushd ${i}
      ./configure --prefix=/usr --mandir=/usr/share/man --disable-xprint
      make
      popd
    fi
  done
}

do_package() {
  
  for i in *; do
    if [ -d ${i} ]; then
      pushd ${i}
      make DESTDIR=${CACHE_PATH} install
      install -D -m644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE.${i%-*}
      popd
    fi
  done

  install -D -m644 LICENSE.listres ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE.listres
  install -D -m644 LICENSE.viewres ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE.viewres
}
