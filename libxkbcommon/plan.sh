pkg_origin=cosmos

pkg_name=libxkbcommon
pkg_version=0.7.1
pkg_description="Keyboard handling library using XKB data"
pkg_upstream_url="https://xkbcommon.org/"
pkg_license=('custom')
pkg_deps=('xkeyboard-config' 'glibc' 'wayland-protocols')
pkg_build_deps=('doxygen' 'xorg-util-macros')
pkg_source=("https://xkbcommon.org/download/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('947ba609cb0239b9462127d5cf8908ee')

do_build() {
  
  #./autogen.sh
  ./configure --prefix=/usr --disable-static
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -Dm644 LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
