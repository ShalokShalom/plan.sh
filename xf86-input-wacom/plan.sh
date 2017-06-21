pkg_origin=cosmos

pkg_name=xf86-input-wacom
pkg_version=0.34.2
pkg_description="X.Org Wacom tablet driver."
pkg_upstream_url="http://linuxwacom.sourceforge.net/wiki/index.php/Main_Page"
pkg_license=('GPL')
pkg_deps=('libxi' 'libxrandr' 'libxinerama' 'systemd')
pkg_build_deps=('xorg-server' 'libxext' 'resourceproto' 'scrnsaverproto')
pkg_source=("https://downloads.sourceforge.net/project/linuxwacom/${pkg_name}/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('bfc2bb315210f735bcdb9f7887c9d609')

do_build() {
  
  ./configure --prefix=/usr 
  make
}

do_package() {
  
  make DESTDIR=${CACHE_PATH} install
}

