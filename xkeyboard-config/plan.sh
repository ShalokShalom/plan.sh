pkg_origin=cosmos

pkg_name=xkeyboard-config
pkg_version=2.21
pkg_description="X keyboard configuration files"
pkg_license=('custom')
pkg_upstream_url="https://www.freedesktop.org/wiki/Software/XKeyboardConfig"
pkg_deps=('xorg-xkb-utils')
pkg_build_deps=('intltool')
pkg_source=("https://www.x.org/releases/individual/data/${pkg_name}/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('af9498e8954907d0a47f0f7b3d21e1ef')

do_build() {
  
  ./configure --prefix=/usr \
      --with-xkb-base=/usr/share/X11/xkb \
      --with-xkb-rules-symlink=xorg \
      --enable-compat-rules=yes
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install
  
  rm -f ${CACHE_PATH}/usr/share/X11/xkb/compiled
  install -m755 -d ${CACHE_PATH}/var/lib/xkb
  install -m755 -d ${CACHE_PATH}/usr/share/licenses/${pkg_name}
  install -m644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/
}
