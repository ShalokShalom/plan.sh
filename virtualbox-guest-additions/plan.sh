pkg_origin=

pkg_name=virtualbox-guest-additions
pkg_version=5.1.22
_pkg_version=5.1.22
pkg_description='The official VirtualBox Guest Additions ISO image'
pkg_upstream_url='http://www.virtualbox.org'
pkg_license=('custom:PUEL')
install=virtualbox-guest-additions.install
pkg_deps=('make' 'pkg-config')
pkg_source=("http://download.virtualbox.org/virtualbox/${_pkg_version}/VBoxGuestAdditions_${_pkg_version}.iso"
        'vboxservice.service'
        'LICENSE')
noextract=(VBoxGuestAdditions_${_pkg_version}.iso)
pkg_shasum=('a92d692da9ec44f1bede2ccda88bca52'
         'f50243f38c6dd103e7e944f635d66fa0'
         'c32cd777d97ebc094af7548e2fd866c2')

do_package() {
  install -Dm 644 VBoxGuestAdditions_${_pkg_version}.iso \
    ${pkg_prefix}/usr/lib/virtualbox/additions/VBoxGuestAdditions.iso
  
  #install -Dm0644 vboxservice.service ${pkg_prefix}/usr/lib/systemd/system/vboxservice.service
  install -Dm 644 ${CACHE_PATH}/LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
