pkg_origin=cosmos

pkg_name=xorg-server
pkg_version=1.19.3
# major updates build xorg-server/xf86-input-evdev/xorg-server again
pkg_description="X.Org X servers"
pkg_license=('custom')
pkg_upstream_url="https://xorg.freedesktop.org"
pkg_deps=('xproto' 'randrproto' 'renderproto' 'xextproto' 'inputproto' 'kbproto' 'fontsproto'
         'videoproto' 'dri2proto' 'dri3proto' 'xineramaproto' 'xorg-util-macros' 'pixman'
         'libpciaccess' 'libxfont2' 'libxi' 'mesa' 'libgcrypt' 'libxv' 'libxau' 'libxaw'
         'libxrender' 'libdmx' 'libdrm' 'libxfixes' 'libxext' 'libxdmcp' 'libxshmfence'
         'presentproto' 'systemd' 'xf86-input-evdev' 'xkeyboard-config' 'xorg-xkb-utils'
         'xorg-fonts-misc' 'xf86dgaproto' 'xcb-util' 'xcb-util-image' 'xcb-util-keysyms'
         'xcb-util-renderutil' 'xcb-util-wm' 'libepoxy' 'libgl' 'wayland-protocols')
pkg_build_deps=('libx11' 'xf86driproto' 'xcmiscproto' 'xtrans' 'bigreqsproto'
             'compositeproto' 'recordproto' 'scrnsaverproto' 'resourceproto' 'libxkbfile'
             'libxmu' 'dmxproto' 'libxtst' 'libxres' 'links')
#backup=('etc/X11/xorg.conf.d/10-evdev.conf' 'etc/X11/xorg.conf.d/10-quirks.conf')
groups=('xorg')
pkg_source=("https://xorg.freedesktop.org/releases/individual/xserver/${pkg_name}-${pkg_version}.tar.bz2"
        'nvidia-drm-outputclass.conf'
        'xvfb-run'
        'xvfb-run.1')
pkg_shasum=('015d2fc4b9f2bfe7a626edb63a62c65e'
         '1b0626939623e92c04809fb76cb505dd'
         '52fd3effd80d7bc6c1660d4ecf23d31c'
         '376c70308715cd2643f7bff936d9934b')

do_build() {

  autoreconf -fiv
  ./configure --prefix=/usr \
      --enable-ipv6 \
      --enable-dri \
      --enable-dmx \
      --enable-xvfb \
      --enable-xnest \
      --enable-composite \
      --enable-xcsecurity \
      --enable-xorg \
      --enable-xephyr \
      --enable-xwayland \
      --enable-glamor \
      --enable-kdrive \
      --enable-kdrive-evdev \
      --enable-kdrive-kbd \
      --enable-kdrive-mouse \
      --enable-config-udev \
      --enable-systemd-logind \
      --enable-suid-wrapper \
      --enable-record \
      --disable-xfbdev \
      --disable-xfake \
      --disable-static \
      --sysconfdir=/etc/X11 \
      --localstatedir=/var \
      --libexecdir=/usr/lib/xorg-server \
      --with-xkb-path=/usr/share/X11/xkb \
      --with-xkb-output=/var/lib/xkb \
      --with-fontrootdir=/usr/share/fonts
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install

  install -m755 -d ${CACHE_PATH}/usr/lib/xorg
  install -m644 dix/protocol.txt ${CACHE_PATH}/usr/lib/xorg/

  install -m755 ${CACHE_PATH}/xvfb-run ${CACHE_PATH}/usr/bin/
  install -m644 ${CACHE_PATH}/xvfb-run.1 ${CACHE_PATH}/usr/share/man/man1/

  install -m755 -d ${CACHE_PATH}/var/lib/xkb

  install -m755 -d ${CACHE_PATH}/etc/X11
  mv ${CACHE_PATH}/usr/share/X11/xorg.conf.d ${CACHE_PATH}/etc/X11/
  install -m644 ${CACHE_PATH}/nvidia-drm-outputclass.conf ${CACHE_PATH}/etc/X11/xorg.conf.d/

  rmdir ${CACHE_PATH}/usr/share/X11

  # Needed for non-mesa drivers, libgl will restore it
  mv ${CACHE_PATH}/usr/lib/xorg/modules/extensions/libglx.so \
     ${CACHE_PATH}/usr/lib/xorg/modules/extensions/libglx.xorg

  rm -rf ${CACHE_PATH}/var/log

  install -m755 -d ${CACHE_PATH}/usr/share/licenses/${pkg_name}
  install -m644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/
}
