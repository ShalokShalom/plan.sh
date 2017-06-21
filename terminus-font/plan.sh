pkg_origin=cosmos

pkg_name=terminus-font
pkg_version=4.40
pkg_upstream_url="http://sourceforge.net/projects/terminus-font/"
pkg_description="A superb, monospace bitmap font (for X11 and console)"
pkg_license=('GPL2' 'custom:OFL')
pkg_deps=('xorg-fonts-encodings' 'xorg-fonts-alias' 'xorg-font-utils' 'fontconfig')
install=terminus-font.install
pkg_source=("https://downloads.sourceforge.net/project/terminus-font/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('1e1df0d2c612c374ebe7966f90f04e0c')

do_build() { 
  
  sh ./configure --prefix=/usr \
    --x11dir=/usr/share/fonts/local/ \
    --psfdir=/usr/share/kbd/consolefonts/ 
  make 
}

do_package() {
  make DESTDIR=${CACHE_PATH} install

  install -Dm644 75-yes-terminus.conf ${CACHE_PATH}/etc/fonts/conf.avail/75-yes-terminus.conf
  install -Dm644 OFL.TXT ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
