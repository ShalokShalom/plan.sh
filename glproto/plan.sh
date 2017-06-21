pkg_origin=cosmos

pkg_name=glproto
pkg_version=1.4.17
pkg_description="X11 OpenGL extension wire protocol"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_source=("http://xorg.freedesktop.org/releases/individual/proto/${pkg_name}-${pkg_version}.tar.bz2"
        'COPYING')
pkg_shasum=('5565f1b0facf4a59c2778229c1f70d10'
         'a2228066bf4e15d351290deec0d9c250')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR="${pkg_prefix}" install
  
  install -Dm644 COPYING "${pkg_prefix}/usr/share/licenses/${pkg_name}/COPYING"
}
