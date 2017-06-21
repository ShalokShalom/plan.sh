pkg_origin=cosmos

pkg_name=xf86-input-synaptics
pkg_version=1.9.0
pkg_description="Synaptics driver for notebook touchpads"
pkg_license=('custom')
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_deps=('libxtst' 'mtdev' 'libevdev')
pkg_build_deps=('xorg-server>=1.19.1' 'libxi' 'libx11' 'resourceproto' 'scrnsaverproto')
groups=('xorg-drivers' 'xorg')
backup=('etc/X11/xorg.conf.d/50-synaptics.conf')
pkg_source=("http://xorg.freedesktop.org/releases/individual/driver/${pkg_name}-${pkg_version}.tar.bz2"
        'tapbutton.patch')
pkg_shasum=('58e5b7722a402114093bf193962d1e3a'
         '228986de479c1e3795266d745a373f42')

do_build() {
  patch -p1 -i ${CACHE_PATH}/tapbutton.patch
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install
  
  install -m755 -d ${CACHE_PATH}/etc/X11/xorg.conf.d
  install -m644 conf/70-synaptics.conf ${CACHE_PATH}/etc/X11/xorg.conf.d/
  install -m755 -d ${CACHE_PATH}/usr/share/licenses/${pkg_name}
  install -m644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/

  rm -rf ${CACHE_PATH}/usr/share/X11
}
