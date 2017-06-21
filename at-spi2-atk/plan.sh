pkg_origin=cosmos

pkg_name=at-spi2-atk
pkg_version=2.24.1
_pkg_version=2.24
pkg_description="A GTK+ module that bridges ATK to D-Bus at-spi"
pkg_upstream_url="http://www.gnome.org"
pkg_license=('GPL2')
pkg_deps=('at-spi2-core' 'libx11' 'atk')
pkg_build_deps=('intltool')
pkg_source=("https://download.gnome.org/sources/${pkg_name}/${_pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('79388fbc4dc7f27394556dd389aeb594')

do_build() {

  autoreconf --force --install

  ./configure --prefix=/usr \
    --sysconfdir=/etc \
    --disable-schemas-compile
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}

