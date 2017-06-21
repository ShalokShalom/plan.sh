pkg_origin=cosmos

pkg_name=libxmi
pkg_version=1.2
pkg_description="library for rasterizing 2-D vector graphics"
pkg_upstream_url="https://www.gnu.org/software/libxmi/libxmi.html"
pkg_license=('GPL')
pkg_deps=('glibc')
pkg_source=("https://mirror.frgl.pw/gnu/libxmi/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('4e6935484f0ad71b531920bf4c546b47')

do_build() {
  autoreconf --force --install
  
  ./configure --prefix=/usr --infodir=/usr/share/info
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
