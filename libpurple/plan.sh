pkg_origin=cosmos

_pkgbase=pidgin
pkg_name=libpurple
pkg_version=2.12.0
pkg_description="IM library extracted from Pidgin"
pkg_upstream_url="http://pidgin.im/"
pkg_license=('GPL')
pkg_deps=('libsasl' 'dbus-glib' 'nss' 'libidn' 'farstream')
pkg_build_deps=('startup-notification' 'libxss' 'python2' 'avahi' 'tk'
             'ca-certificates' 'intltool')
pkg_deps=('dbus-python2: for purple-remote and purple-url-handler')
pkg_source=("http://downloads.sourceforge.net/${_pkgbase}/${_pkgbase}-${pkg_version}.tar.bz2")
pkg_shasum=('8287400c4e5663e0e7844e868d5152af')

do_build() {

    ./configure --prefix=/usr \
                --sysconfdir=/etc \
                --disable-schemas-install \
                --disable-meanwhile \
                --disable-gnutls \
                --disable-gtkui \
                --disable-screensaver \
                --disable-sm \
                --disable-nm \
                --disable-gtkspell \
                --enable-cyrus-sasl \
                --disable-doxygen \
                --with-python=/usr/bin/python2 \
                --with-system-ssl-certs=/etc/ssl/certs
    make
}

do_package() {
    
    for dir in libpurple share/sounds share/ca-certs m4macros po
    do  make -C "${dir}" DESTDIR="${pkg_prefix}" install
    done
}
