pkg_origin=cosmos

pkg_name=telepathy-logger
pkg_version=0.8.2
pkg_description="Telepathy framework logging daemon"
pkg_upstream_url="https://telepathy.freedesktop.org/wiki/Logger"
pkg_license=('LGPL2.1')
pkg_deps=('telepathy-glib' 'sqlite3' 'libxml2' 'dconf')
pkg_build_deps=('intltool' 'gobject-introspection' 'libxslt')
pkg_source=("https://telepathy.freedesktop.org/releases/telepathy-logger/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('c2f6a31c76cbdf8790500cf4f872ba71')

do_build() {

  ./configure --prefix=/usr \
    --sysconfdir=/etc \
    --libexecdir=/usr/lib/telepathy \
    --disable-static \
    --disable-schemas-compile
  make
}

do_package() {
  
  make DESTDIR=${CACHE_PATH}/ install
  rm -r ${CACHE_PATH}/usr/share/gtk-doc
}

