pkg_origin=cosmos

pkg_name=xorg-xinit
pkg_version=1.3.4
pkg_description="X.Org initialisation program "
pkg_license=('custom')
pkg_upstream_url="https://xorg.freedesktop.org/"
pkg_deps=('libx11' 'xorg-xauth' 'inetutils' 'xorg-server-utils')
pkg_build_deps=('xorg-util-macros')
optpkg_deps=('xterm')
backup=('etc/X11/xinit/xserverrc'
        'etc/X11/xinit/xinitrc')
groups=('xorg')
pkg_source=("https://xorg.freedesktop.org/releases/individual/app/xinit-${pkg_version}.tar.bz2"
        '06_move_serverauthfile_into_tmp.diff'
        'fs25361.patch'
        'xserverrc')
pkg_shasum=('4e928452dfaf73851413a2d8b8c76388'
         'abd072ec435ce084cf4e89c58f83d45c'
         '73a597d3fb7f5b9487318ac8cfd4bedf'
         '4deba1b7f2cc7f93b304b956023e65d6')

do_build() {
  patch -p1 -i ${CACHE_PATH}/06_move_serverauthfile_into_tmp.diff
  patch -p1 -i ${CACHE_PATH}/fs25361.patch
  sed -i -e 's|XSLASHGLOB.sh|XSLASHGLOB|' xinitrc.cpp
  
  ./configure --prefix=/usr --with-xinitdir=/etc/X11/xinit
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install

  install -m755 -d ${CACHE_PATH}/etc/skel
  install -m644 ${CACHE_PATH}/xserverrc ${CACHE_PATH}/etc/X11/xinit/xserverrc
  install -m755 -d ${CACHE_PATH}/usr/share/licenses/${pkg_name}
  install -m644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/
}
