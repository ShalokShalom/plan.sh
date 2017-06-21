pkg_origin=cosmos

pkg_name=lockdown-ms
pkg_version=20130326
pkg_description="SecureBoot keys, which mimic MS certified UEFI machine"
pkg_upstream_url="https://fedoraproject.org/wiki/Testing_secureboot_with_KVM"
pkg_license=('GPL' 'LGPL2.1')
pkg_source=("https://fedorapeople.org/~crobinso/secureboot/LockDown_ms.efi")
pkg_shasum=('4fab954aceeb8963bae4e2dc241d1905')

do_package() {
    install -D -m0644 LockDown_ms.efi ${pkg_prefix}/usr/lib/lockdown-ms/LockDown_ms.efi
}
