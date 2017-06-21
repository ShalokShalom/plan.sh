pkg_origin=cosmos

pkg_name=cairo
pkg_version=1.14.10
pkg_description="Cairo vector graphics library"
pkg_license=('LGPL' 'MPL')
pkg_upstream_url="https://cairographics.org/"
pkg_deps=('libpng' 'libxrender' 'libxext' 'fontconfig' 'pixman' 'glib2' 'sh' 'mesa'
         'libgl' 'lzo2')
pkg_build_deps=('librsvg' 'poppler-glib' 'libspectre')
pkg_source=("https://cairographics.org/releases/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('146f5f4d0b4439fc3792fd3452b7b12a')

do_build() {

#  autoreconf -vfi
  ./configure --prefix=/usr \
	--sysconfdir=/etc \
	--localstatedir=/var \
	--disable-static \
	--enable-tee \
	--enable-gl \
	--enable-egl \
	--enable-svg \
	--enable-ps \
	--enable-pdf \
	--disable-xlib-xcb 

  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
