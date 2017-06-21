pkg_origin=cosmos

pkg_name=telepathy-haze
pkg_version=0.8.0
pkg_description="A telepathy-backend to use libpurple (Pidgin) protocols."
pkg_upstream_url="http://telepathy.freedesktop.org"
pkg_license=('GPL')
pkg_deps=('telepathy-glib' 'libpurple')
pkg_build_deps=('libxslt' 'python2')
install=telepathy-haze.install
groups=('telepathy')
pkg_source=("http://telepathy.freedesktop.org/releases/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz"
        'contact-list.patch')
pkg_shasum=('b9ee3638833fb50db6276d1b771820b0'
         '41c0c7b49ba3afd0e948513e2bcc677b')

do_build() {
  # https://bugs.freedesktop.org/show_bug.cgi?id=47005
  patch -p1 -i ${CACHE_PATH}/contact-list.patch
  # fix compatibility with libpurple 2.10.12 & up
  sed -i 's|PURPLE_MEDIA_NETWORK_PROTOCOL_TCP;|PURPLE_MEDIA_NETWORK_PROTOCOL_TCP_PASSIVE;|' src/media-stream.c
  
  ./configure --prefix=/usr --libexecdir=/usr/lib/telepathy
  make
}

do_package() {
  
  make DESTDIR=${CACHE_PATH} install
}
