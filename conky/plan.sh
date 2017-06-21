pkg_origin=

pkg_name=conky
pkg_version=1.10.6
pkg_description="An advanced, highly configurable system monitor for X based on torsmo"
pkg_upstream_url="http://conky.sourceforge.net/"
pkg_license=('custom')
pkg_deps=('alsa-lib' 'libxml2' 'curl' 'wireless_tools' 'libxft' 'glib2' 'libxdamage' 'imlib2' 'mpd' 'lua'
         'libxinerama')
pkg_build_deps=('pkgconfig' 'cmake')
backup=('etc/conky/conky.conf' 'etc/conky/conky_no_x11.conf')
pkg_source=("https://github.com/brndnmtthws/conky/archive/v${pkg_version}.tar.gz"
        'conky.conf')
pkg_shasum=('bcd9e0ff7304e14f07aea53efa73998f'
         '3e8bc1cf7cf7587ccc5b333ef33284e0')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DDOC_PATH=/etc/conky \
    -DBUILD_WLAN=true \
    -DBUILD_IMLIB2=true \
    -DBUILD_MPD=true \
    -DBUILD_Cpkg_upstream_url=true \
    -DBUILD_RSS=true \
    -DBUILD_XDBE=true
  make
}


do_package() {
  cd build
  make DESTDIR=${pkg_prefix} install 
  
  #rm ${pkg_prefix}/etc/conky/conky.conf
  install -D -m755 ${CACHE_PATH}/conky.conf ${pkg_prefix}/etc/conky/conky.conf
  
  install -D -m644 ../${pkg_name}-${pkg_version}/COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
         

