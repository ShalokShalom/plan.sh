pkg_origin=cosmos
# toolchain build order: linux-api-headers->glibc->binutils->gcc->binutils->glibc

pkg_name=linux-api-headers
pkg_version=4.11.4
_basever=4.11
pkg_description="Kernel headers sanitized for use in userspace"
pkg_upstream_url="http://www.gnu.org/software/libc"
pkg_license=('GPL2')
pkg_source=("http://www.kernel.org/pub/linux/kernel/v4.x/linux-${_basever}.tar.xz"
        "http://www.kernel.org/pub/linux/kernel/v4.x/patch-${pkg_version}.xz")
pkg_shasum=('251a5deee0fa6daf3f356b1bbda9eab8'
         '6a339a5b60e6a65676e6c16fb23827f5')

do_build() {
  cd ${CACHE_PATH}/linux-${_basever}
  [[ $pkg_version != $_basever ]] && patch -p1 -i ${CACHE_PATH}/patch-${pkg_version} || true

  make mrproper
  make headers_check
}

do_package() {
  cd ${CACHE_PATH}/linux-${_basever}
  make INSTALL_HDR_PATH=${pkg_prefix}/usr headers_install

  # use headers from libdrm
  rm -r ${pkg_prefix}/usr/include/drm
  
  # clean-up unnecessary files generated during install
  find ${pkg_prefix} \( -name .install -o -name ..install.cmd \) -delete
}
