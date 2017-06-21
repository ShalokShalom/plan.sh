pkg_origin=cosmos

pkg_name=gwenhywfar
pkg_version=4.17.0
_dnrel=205
pkg_description="OS abstraction functions for various projects"
pkg_upstream_url="http://www.aquamaniac.de"
pkg_license=("LGPL")
pkg_deps=('openssl' 'gnutls' 'libgcrypt' 'qt5-base')
pkg_build_deps=('qt5-tools')
pkg_source=("gwenhywfar-$pkg_version.tar.gz::http://www2.aquamaniac.de/sites/download/download.php?package=01&release=${_dnrel}&file=01&dummy=gwenhywfar-$pkg_version.tar.gz"
        'gnutls34.patch')
pkg_shasum=('00c811c7044589fe157387f72d1af191'
         '1197ac1f8378b3b3a8ed12169fcb57f9')

do_build() {
  #patch -p1 -i ${CACHE_PATH}/gnutls34.patch
  
  ./configure --prefix=/usr \
        --sysconfdir=/etc \
        --enable-ssl \
        --with-qt5-qmake=/usr/lib/qt5/bin/qmake \
        --with-qt5-moc=/usr/lib/qt5/bin/moc \
        --with-qt5-uic=/usr/lib/qt5/bin/uic \
        --with-guis=qt5
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
