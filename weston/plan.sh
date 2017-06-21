pkg_origin=

pkg_name=weston
pkg_version=2.0.0
pkg_description='Reference implementation of a Wayland compositor'
pkg_upstream_url='http://wayland.freedesktop.org'
pkg_license=('MIT')
pkg_deps=('libxkbcommon' 'mesa' 'pango' 'poppler-glib' 'mtdev' 'libxcursor' 'glu' 'libunwind'
         'pixman' 'xkeyboard-config' 'colord' 'libwebp' 'libva' 'libinput' 'wayland-protocols')
pkg_source=("http://wayland.freedesktop.org/releases/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('15f38945942bf2a91fe2687145fb4c7d')

do_build() {
   cd ${pkg_name}-${pkg_version}

   ./configure \
       --prefix=/usr \
       --libexecdir=/usr/lib/weston \
       --enable-demo-clients-install \
       --with-cairo=gl \
       --enable-systemd-notify
   make
}

do_package() {
   cd ${pkg_name}-${pkg_version}
   make DESTDIR=${pkg_prefix} install

   install -Dm644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/COPYING
}
