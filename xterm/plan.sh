pkg_origin=
 
pkg_name=xterm
pkg_version=329
pkg_description="X Terminal Emulator"
pkg_upstream_url="http://invisible-island.net/xterm/"
pkg_license=('custom')
pkg_deps=('libxft' 'libxaw' 'ncurses' 'xorg-apps' 'xbitmaps' 'libutempter')
pkg_source=("ftp://invisible-island.net/xterm/${pkg_name}-${pkg_version}.tgz"
        'LICENSE')
pkg_shasum=('af560754441332d8114301f4bb43f523'
         '10ecc3f8ee91e3189863a172f68282d2')

do_build() {
  cd ${pkg_name}-${pkg_version}
  ./configure --prefix=/usr \
      --libdir=/etc \
      --mandir=/usr/share/man \
      --with-app-defaults=/usr/share/X11/app-defaults/ \
      --with-x \
      --disable-full-tgetent \
      --disable-imake \
      --enable-ansi-color \
      --enable-88-color \
      --enable-256-color \
      --enable-broken-osc \
      --enable-broken-st \
      --enable-load-vt-fonts \
      --enable-i18n \
      --enable-wide-chars \
      --enable-doublechars \
      --enable-warnings \
      --enable-tcap-query \
      --enable-logging \
      --enable-dabbrev \
      --enable-freetype \
      --enable-luit \
      --enable-mini-luit \
      --enable-narrowproto \
      --enable-exec-xterm \
      --with-tty-group=tty \
      --with-utempter
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix} install
  chmod 0755 ${pkg_prefix}/usr/bin/xterm

  install -m755 -d ${pkg_prefix}/usr/share/licenses/${pkg_name}
  install -m644 ${CACHE_PATH}/LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/
  install -m755 -d ${pkg_prefix}/usr/share/applications
  install -m644 ${CACHE_PATH}/${pkg_name}-${pkg_version}/{xterm,uxterm}.desktop ${pkg_prefix}/usr/share/applications/
}
