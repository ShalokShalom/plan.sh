pkg_origin=cosmos

pkg_name=squashfs-tools
pkg_version=4.3
pkg_description="Tools for squashfs, a highly compressed read-only filesystem for Linux."
pkg_upstream_url="http://squashfs.sourceforge.net"
pkg_license=("GPL")
pkg_deps=('zlib' 'glibc' 'lzo2' 'xz' 'lz4')
pkg_source=("http://downloads.sourceforge.net/sourceforge/squashfs/squashfs${pkg_version}.tar.gz")
pkg_shasum=('d92ab59aabf5173f2a59089531e30dbf')

do_build() {
    cd ${CACHE_PATH}/squashfs${pkg_version}/${pkg_name}
    
    make XZ_SUPPORT=1 LZO_SUPPORT=1 LZMA_XZ_SUPPORT=1 LZ4_SUPPORT=1
}

do_package() {
    cd ${CACHE_PATH}/squashfs${pkg_version}/${pkg_name}
    
    install -Dm755 mksquashfs ${pkg_prefix}/sbin/mksquashfs
    install -m755 unsquashfs ${pkg_prefix}/sbin/unsquashfs
}
