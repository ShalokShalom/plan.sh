pkg_origin=cosmos

pkg_name=libotr
pkg_version=4.1.1
pkg_description='Off-the-Record Messaging Library and Toolkit.'
pkg_upstream_url='http://www.cypherpunks.ca/otr/'
pkg_license=('GPL' 'LGPL')
pkg_deps=('libgcrypt')
pkg_source=("http://www.cypherpunks.ca/otr/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('dac5a8778a35f674c046ddf5d97e4d81')

do_build() {
	
    ./configure --prefix=/usr \
        --mandir=/usr/share/man \
        --disable-static 
    make
}

do_package() {
	
    make DESTDIR="$pkg_prefix" install
}
