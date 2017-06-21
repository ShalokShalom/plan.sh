pkg_origin=cosmos

pkg_name=opencore-amr
pkg_version=0.1.5
pkg_description="Open source implementation of the Adaptive Multi Rate (AMR) speech codec"
pkg_license=('APACHE')
pkg_upstream_url="http://opencore-amr.sourceforge.net/"
pkg_deps=('gcc-libs')
pkg_source=("https://downloads.sourceforge.net/sourceforge/opencore-amr/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('e0798587b91411cc092aa73091a97dfc')

do_build() {

  ./configure --prefix=/usr --disable-static
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix}/ install
}

