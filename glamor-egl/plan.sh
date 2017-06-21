pkg_origin=cosmos

pkg_name=glamor-egl
pkg_version=0.6.0
pkg_description='OpenGL based 2D rendering acceleration library'
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('libgl')
pkg_build_deps=('xorg-server' 'resourceproto' 'scrnsaverproto' 'git')
pkg_source=("http://xorg.freedesktop.org/releases/individual/driver/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('b3668594675f71a75153ee52dbd35535')
#pkg_source=("glamor-egl::git://anongit.freedesktop.org/xorg/driver/glamor")
#pkg_shasum=('SKIP')

do_build() {
  
  ./configure --prefix=/usr --disable-static --enable-glx-tls --enable-xv \

  make
}

do_package() {

  make "DESTDIR=${pkg_prefix}" install

  install -m755 -d "${pkg_prefix}/usr/share/licenses/${pkg_name}"
  install -m644 COPYING "${pkg_prefix}/usr/share/licenses/${pkg_name}/"
}
