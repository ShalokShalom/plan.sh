pkg_origin=cosmos

pkg_name=libxkbui
pkg_version=1.0.2
pkg_description="X11 keyboard UI presentation library"
pkg_upstream_url="https://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('libxt' 'libxkbfile')
pkg_build_deps=('pkgconfig')
pkg_source=("https://xorg.freedesktop.org/releases/individual/lib/${pkg_name}-${pkg_version}.tar.bz2"
        'LICENSE')
pkg_shasum=('1143e456f7429e18e88f2eadb2f2b6b1'
         'd1efaa1271fc028cd5bec33f836ee9ef')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -D -m644 ../LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
