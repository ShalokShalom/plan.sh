pkg_origin=cosmos

pkg_name=epsoneplijs
pkg_version=0.4.1
pkg_description="Printer driver which gives ghostscript the ability to print to Epson EPL-5700L, EPL-5800L, EPL-5900L, EPL-6100L and EPL-6200L laser printers."
pkg_license=('custom')
pkg_upstream_url="http://sourceforge.net/projects/epsonepl/"
pkg_deps=('cups' 'ghostscript' 'libusb' 'cups-filters')
pkg_source=("https://sourceforge.net/projects/epsonepl/files/epsonepl/${pkg_version}/${pkg_name}-${pkg_version}.tgz" 
        'LICENSE' )
pkg_shasum=('0840e15c6a96584138d9a1045c16997d'
         '13d64edc89b1551e4c88be3b21d4a39a')

do_build() {
    
    ./configure --prefix=/usr --with-libusb
    make
}

do_package() {
    mkdir -p ${pkg_prefix}/usr/bin
    make prefix=${pkg_prefix}/usr install

    mkdir -p ${pkg_prefix}/usr/share/foomatic/db/source/driver/
    cp foomatic/driver/*.* ${pkg_prefix}/usr/share/foomatic/db/source/driver/
    mkdir -p ${pkg_prefix}/usr/share/foomatic/db/source/opt/
    cp foomatic/opt/*.* ${pkg_prefix}/usr/share/foomatic/db/source/opt/
    mkdir -p ${pkg_prefix}/usr/share/foomatic/db/source/printer/
    cp foomatic/printer/*.* ${pkg_prefix}/usr/share/foomatic/db/source/printer/
    mkdir -p ${pkg_prefix}/usr/share/foomatic/db/source/PPD/Epson/
    cp foomatic_PPDs/Epson-EPL-*-cups.ppd.gz ${pkg_prefix}/usr/share/foomatic/db/source/PPD/Epson/
    mkdir -p ${pkg_prefix}/usr/share/cups/model/
    cp -av foomatic_PPDs/Epson-EPL-*-cups.ppd.gz ${pkg_prefix}/usr/share/cups/model/

    install -D -m 644 ../LICENSE ${pkg_prefix}/usr/share/licenses/$pkg_name/LICENSE
}
