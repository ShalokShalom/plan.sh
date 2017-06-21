pkg_origin=
pkg_name=libxklavier
pkg_version=5.2.1
pkg_description="High-level API for X Keyboard Extension"
pkg_license=('LGPL')
pkg_deps=('libxkbfile' 'libxml2' 'glib2' 'xkeyboard-config' 'libxi' 'iso-codes')
pkg_build_deps=('pkg-config')
pkg_upstream_url="http://gswitchit.sourceforge.net"
pkg_source=("http://ftp.gnome.org/pub/gnome/sources/${pkg_name}/5.2/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('a7a1ca8ae493fb652e3456a6b3a0b07514447161aab41feed96b968f2d338b5e')

do_build() {
  cd "${CACHE_PATH}/${pkg_name}-${pkg_version}"
  
  ./configure --prefix=/usr --with-xkb-base=/usr/share/X11/xkb --disable-static 
      
  make 
}

do_package() {
  cd "${CACHE_PATH}/${pkg_name}-${pkg_version}"
  
  make DESTDIR="${pkg_prefix}" install 
}
