pkg_origin=cosmos

pkg_name=at-spi2-core
pkg_version=2.24.1
_pkg_version=2.24
pkg_description="Protocol definitions and daemon for D-Bus at-spi"
pkg_upstream_url="https://www.gnome.org"
pkg_license=('GPL2')
pkg_deps=('dbus' 'glib2' 'libxtst')
pkg_build_deps=('intltool' 'gobject-introspection')
pkg_source=("https://download.gnome.org/sources/at-spi2-core/${_pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('61d0a471e693292934a73f288ebff35c')

do_build() {

  sed -i -e '/AC_PATH_XTRA/d' configure.ac
  autoreconf --force --install

  ./configure --prefix=/usr \
    --sysconfdir=/etc \
    --libexecdir=/usr/lib/at-spi2-core \
    --disable-xevie
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}

