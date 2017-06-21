pkg_origin=cosmos

pkg_name=prebootloader
pkg_version=20130206
pkg_description="Linux Foundation UEFI secure boot system"
pkg_upstream_url="http://www.linuxfoundation.org/news-media/blogs/browse/2012/10/linux-foundation-uefi-secure-boot-system-open-source"
# http://www.rodsbooks.com/efi-bootloaders/secureboot.html#prebootloader
# http://git.kernel.org/cgit/linux/kernel/git/jejb/efitools.git
# http://blog.hansenpartnership.com/uefi-secure-boot/
# http://blog.hansenpartnership.com/linux-foundation-secure-boot-system-released
pkg_license=('GPL' 'LGPL2.1')
pkg_source=("https://blog.hansenpartnership.com/wp-uploads/2013/PreLoader.efi"
        "https://blog.hansenpartnership.com/wp-uploads/2013/HashTool.efi"
        "https://blog.hansenpartnership.com/wp-uploads/2013/KeyTool.efi")
pkg_shasum=('4f7a4f566781869d252a09dc84923a82'
         '45639d23aa5f2a394b03a65fc732acf2'
         'b80145dc9d21c822a14a048f1361e36f')

do_package() {
    install -D -m0644 PreLoader.efi ${pkg_prefix}/usr/lib/prebootloader/PreLoader.efi
    install -D -m0644 HashTool.efi ${pkg_prefix}/usr/lib/prebootloader/HashTool.efi
    install -D -m0644 KeyTool.efi ${pkg_prefix}/usr/lib/prebootloader/KeyTool.efi
}
