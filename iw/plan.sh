pkg_origin=cosmos

pkg_name=iw
pkg_version=4.9
pkg_description="nl80211 based CLI configuration utility for wireless devices"
pkg_upstream_url="http://wireless.kernel.org/en/users/Documentation/iw"
pkg_license=('GPL')
pkg_deps=('libnl')
pkg_build_deps=('linux-api-headers' 'pkg-config')
pkg_source=("https://www.kernel.org/pub/software/network/${pkg_name}/${pkg_name}-${pkg_version}.tar.xz"
        'version-sh.patch')
pkg_shasum=('02d36655b45a0288feb0e87e461e365a'
         '9e8d3294410721165571020a671121da')

do_build() {
  cd ${pkg_name}-${pkg_version}
  #patch -p0 -i ${CACHE_PATH}/version-sh.patch
  
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  
  make DESTDIR=${pkg_prefix} install
}
