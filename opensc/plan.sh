pkg_origin=cosmos

pkg_name=opensc
pkg_version=0.16.0
pkg_description='Tools and libraries for smart cards'
pkg_upstream_url='https://github.com/OpenSC/OpenSC/wiki'
pkg_license=('LGPL')
backup=('etc/opensc.conf')
pkg_deps=('openssl' 'pcsclite' 'libltdl')
pkg_build_deps=('docbook-xsl')
pkg_source=("https://github.com/OpenSC/OpenSC/archive/$pkg_version.tar.gz")
pkg_shasum=('4148305139a80ec3d5db8bcccc89217f')

do_build() {
    export LIBS=-lltdl
    ./bootstrap
    _sheetdir=(/usr/share/xml/docbook/xsl-stylesheets-*)
    
    ./configure \
          --prefix=/usr \
          --sysconfdir=/etc \
          --enable-man \
          --enable-doc \
          --enable-readline \
          --enable-openssl \
          --enable-pcsc \
          --enable-zlib \
          --enable-sm \
          --with-xsl-stylesheetsdir="$_sheetdir"
    make
}

do_package(){
    make DESTDIR="$pkg_prefix" install
    
    install -D -m644 etc/opensc.conf "$pkg_prefix/etc/opensc.conf"
}

