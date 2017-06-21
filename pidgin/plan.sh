pkg_origin=

# perl issue on server, build locally only
pkg_name=pidgin
pkg_version=2.12.0
pkg_description="Multi-protocol instant messaging client"
pkg_upstream_url="http://pidgin.im/"
pkg_license=('GPL')
pkg_deps=("libpurple=$pkg_version" 'startup-notification' 'gtk2' 'libxss' 'hicolor-icon-theme'
         'libsm' 'libidn' 'avahi' 'networkmanager' 'gst-plugins-good' 'farstream')
pkg_build_deps=('nss' 'libsasl' 'python2' 'tk' 'ca-certificates' 'intltool' )
pkg_source=("http://downloads.sourceforge.net/pidgin/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('8287400c4e5663e0e7844e868d5152af')

do_build() {
  cd ${pkg_name}-$pkg_version

    ./configure --prefix=/usr \
                --sysconfdir=/etc \
                --disable-schemas-install \
                --disable-meanwhile \
                --disable-gnutls \
                --enable-cyrus-sasl \
                --enable-nm \
                --with-python=/usr/bin/python2 \
                --with-system-ssl-certs=/etc/ssl/certs \
                --disable-gtkspell
    make
}

do_package(){
    cd ${pkgbase}-${pkg_version}
    #for linking
    make -C libpurple DESTDIR="${pkg_prefix}" install-libLTLIBRARIES

    make -C pidgin DESTDIR="${pkg_prefix}" install
    make -C doc DESTDIR="${pkg_prefix}" install

    #clean up libpurple
    make -C libpurple DESTDIR="${pkg_prefix}" uninstall-libLTLIBRARIES

    install -D -m 0644 pidgin/data/pidgin.desktop "${pkg_prefix}"/usr/share/applications/pidgin.desktop

    rm -f "${pkg_prefix}"/usr/share/man/man1/finch.1
}


