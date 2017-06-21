pkg_origin=cosmos

pkg_name=libogg
pkg_version=1.3.2
pkg_description="Ogg bitstream and framing library"
pkg_upstream_url="http://www.xiph.org/ogg/"
pkg_license=('BSD')
pkg_deps=('glibc')
pkg_source=("http://downloads.xiph.org/releases/ogg/$pkg_name-$pkg_version.tar.xz")
pkg_shasum=('5c3a34309d8b98640827e5d0991a4015')

do_build() {
    
    ./configure --prefix=/usr 
    make
}

do_package() {
    make DESTDIR=$pkg_prefix install

    install -Dm644 COPYING "$pkg_prefix/usr/share/licenses/$pkg_name/COPYING"
}

