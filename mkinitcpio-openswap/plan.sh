pkg_origin=cosmos

# all credit for this PKGBUILD goes to Jenya Sovetkin <e.sovetkin@gmail.com>
pkg_name=mkinitcpio-openswap
pkg_version=0.0.1
pkg_description="mkinitcpio hook to open swap at boot time"
pkg_upstream_url="https://aur.archlinux.org/packages/mkinitcpio-openswap/"
pkg_license=('unknown')
pkg_deps=('mkinitcpio')
backup=('etc/openswap.conf')
pkg_source=('openswap.hook'
        'openswap.install'
        'openswap.conf')
pkg_shasum=('a5b52e3c3b5dc592f41567b21ec2e9cf'
         'ae743e0fd95cc1c07705cf7c472416b1'
         '101861982a5e2ad64a32a158894bbbea')

do_package() {  
  install -Dm 644 openswap.hook \
     ${pkg_prefix}/usr/lib/initcpio/hooks/openswap
  install -Dm 644 openswap.install \
     ${pkg_prefix}/usr/lib/initcpio/install/openswap
  install -Dm 644 openswap.conf \
     ${pkg_prefix}/etc/openswap.conf
}
