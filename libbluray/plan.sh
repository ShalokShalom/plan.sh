pkg_origin=cosmos

pkg_name=libbluray
pkg_version=1.0.1
pkg_description="Library to access Blu-Ray disks for video playback"
pkg_upstream_url="https://www.videolan.org/developers/libbluray.html"
pkg_license=('LGPL2.1')
pkg_deps=('libxml2' 'freetype2' 'fontconfig')
pkg_build_deps=('apache-ant')
pkg_source=("https://ftp.videolan.org/pub/videolan/libbluray/${pkg_version}/${pkg_name}-${pkg_version}.tar.bz2")
sha512sums=('798d38cc95af87599af5838e5c288f2536a73b33191db8ff3774cf7eb5b835006bea83693f016d47dff551001b98527d8b1f14051f673fb3b28073b820e325d7')

do_build() {
  
  ./configure --prefix=/usr --disable-static --disable-bdjava
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix}/ install
} 
