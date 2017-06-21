pkg_origin=cosmos

pkg_name=xf86-video-intel
pkg_version=2.99.917.18
_commit=6babcf15dd605ef40de53f5c34f95b7fd195edbe
pkg_description="X.org Intel i810/i830/i915/945G/G965+ video drivers"
pkg_upstream_url="http://xorg.freedesktop.org"
pkg_license=('custom')
pkg_deps=('mesa' 'libxvmc' 'libpciaccess' 'libdrm' 'xcb-util' 'libxfixes' 'systemd'
         'libxrandr' 'libxinerama' 'libxcursor' 'libxtst')
pkg_build_deps=('xorg-server>=1.18.1' 'libx11' 'xf86driproto' 'glproto' 'libxrender'
             'resourceproto' 'scrnsaverproto')
groups=('xorg-drivers' 'xorg')
install=xf86-video-intel.install
#pkg_source=("http://xorg.freedesktop.org/releases/individual/driver/${pkg_name}-${pkg_version}.tar.bz2")
pkg_source=("git://anongit.freedesktop.org/git/xorg/driver/xf86-video-intel.git#commit=${_commit}")
pkg_shasum=('SKIP')

do_build() {

  ./autogen.sh
  ./configure --prefix=/usr \
              --libexecdir=/usr/lib \
              --enable-dri \
              --enable-sna \
              --enable-uxa \
              --with-default-accel=sna
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install
  
  install -m755 -d ${CACHE_PATH}/usr/share/licenses/${pkg_name}
  install -m644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/
}
