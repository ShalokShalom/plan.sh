pkg_origin=cosmos

pkg_name=tlp
pkg_version=0.9
pkg_description='Linux Advanced Power Management'
pkg_upstream_url='http://linrunner.de/en/tlp/docs/tlp-linux-advanced-power-management.html'
pkg_license=('GPL2' 'GPL3')
pkg_deps=('bash' 'hdparm' 'perl' 'rfkill' 'wireless_tools' 'networkmanager' 'smartmontools' 
         'iw')
optpkg_deps=('tp_smapi: extend ThinkPad battery functions, SandyBridge and newer' 
            'acpi_call: extend ThinkPad battery functions')
backup=('etc/default/tlp')
pkg_source=("https://github.com/linrunner/TLP/archive/${pkg_version}.tar.gz")
pkg_shasum=('952712c5de56e5fcb9a165b1cd8ba4e0')

do_prepare() {
    #sed -i -e 's|/lib/udev/tlp-usb-udev|/usr/lib/udev/tlp-usb-udev|' TLP-${pkg_version}/tlp.rules
}

do_package() {
    
    export TLP_ULIB='/usr/lib/udev'
    export TLP_NO_INIT='1'
    export TLP_NO_PMUTILS='1'
    export TLP_SYSD='/usr/lib/systemd/system'
    export TLP_WITH_SYSTEMD='1'

    make DESTDIR="${CACHE_PATH}" install

    install -dm 755 "${CACHE_PATH}"/usr/share/man/man{1,8}
    install -m 644 man/*.1 "${CACHE_PATH}"/usr/share/man/man1/
    install -m 644 man/*.8 "${CACHE_PATH}"/usr/share/man/man8/
}

