pkg_origin=cosmos

pkg_name=xorg-fonts-alias
pkg_version=1.0.3
pkg_description="X.org font alias files"
pkg_upstream_url="https://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_source=("https://xorg.freedesktop.org/releases/individual/font/font-alias-${pkg_version}.tar.bz2"
        'LICENSE')
pkg_shasum=('6d25f64796fef34b53b439c2e9efa562'
         'ff91ae6d96d76130482d04653e7a836a')

do_build() {
  
  ./configure --prefix=/usr --with-fontrootdir=/usr/share/fonts
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install
  
  install -Dm644 ../LICENSE ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
