pkg_origin=cosmos

pkg_name=hfsprogs
pkg_version=332.25
pkg_description="HFS/HFS+ user space utils" 
pkg_deps=('libbsd')
pkg_license=('custom:APSL')
pkg_upstream_url="http://www.opensource.apple.com/"
pkg_source=("https://ftp.de.debian.org/debian/pool/main/h/hfsprogs/hfsprogs_${pkg_version}.orig.tar.gz" 
        "https://ftp.de.debian.org/debian/pool/main/h/hfsprogs/hfsprogs_${pkg_version}-11.debian.tar.gz"
        'license'
        'makefile.patch')
pkg_shasum=('261c3de5ec0dcf5244e3f60d79c1d6f1'
        'ce42d7b88de9c41c6192ff3c450a6bd1'
        '771f0a6036a80d929c07df49f9a3d909'
        'e2429944c0192d817c700b8f0dffce6e')

do_build() {
    patch -p1 -i ${CACHE_PATH}/debian/patches/0001-Create-short-Makefiles-for-Debian.patch
    patch -p1 -i ${CACHE_PATH}/debian/patches/0002-Add-exclude-Darwin-specific-code.patch
    patch -p1 -i ${CACHE_PATH}/debian/patches/0005-Remove-Apple-specific-p-from-strings.patch
    patch -p1 -i ${CACHE_PATH}/debian/patches/0004-Fix-compilation-on-64-bit-arches.patch
    patch -p1 -i ${CACHE_PATH}/debian/patches/0003-Add-helper-include-files-absent-from-the-upstream-pa.patch
    patch -p1 -i ${CACHE_PATH}/debian/patches/0006-Adjust-types-for-printing.patch
    patch -p1 -i ${CACHE_PATH}/debian/patches/0007-Fix-path-for-HFS-wrapper-block.patch
    patch -p1 -i ${CACHE_PATH}/debian/patches/0008-Provide-command-line-option-a.patch
    patch -p1 -i ${CACHE_PATH}/debian/patches/0009-Rename-dprintf-to-dbg_printf.patch
    patch -p1 -i ${CACHE_PATH}/debian/patches/0013-Fix-manpages.patch
    patch -p1 -i ${CACHE_PATH}/debian/patches/0010-Rename-custom-macro-nil-with-NULL.patch
    patch -p1 -i ${CACHE_PATH}/debian/patches/0012-Fix-mkfs-not-creating-UUIDs-for-new-filesystems.patch
    patch -p1 -i ${CACHE_PATH}/debian/patches/0011-Fix-types.patch
    patch -p0 -i ${CACHE_PATH}/makefile.patch
    make -f Makefile.lnx
}

do_package() {
    install -d -m 755 ${pkg_prefix}/usr/share/hfsprogs
    install -m 644 newfs_hfs.tproj/hfsbootdata.img ${pkg_prefix}/usr/share/hfsprogs/hfsbootdata
    install -D -m755 newfs_hfs.tproj/newfs_hfs ${pkg_prefix}/sbin/mkfs.hfsplus
    install -D -m755 fsck_hfs.tproj/fsck_hfs ${pkg_prefix}/sbin/fsck.hfsplus
    install -D -m644 ../license ${pkg_prefix}/usr/share/licenses/hfsprogs/APSL
    install -d -m 755 ${pkg_prefix}/usr/share/man/man8/
    install -m 644 newfs_hfs.tproj/newfs_hfs.8 ${pkg_prefix}/usr/share/man/man8/mkfs.hfsplus.8
    install -m 644 fsck_hfs.tproj/fsck_hfs.8 ${pkg_prefix}/usr/share/man/man8/fsck.hfsplus.8
}
