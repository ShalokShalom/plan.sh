pkg_origin=

pkg_name=android-tools
pkg_version=7.1.2_r17
pkg_description="Android platform tools (adb, fastboot)"
pkg_upstream_url="http://tools.android.com/"
pkg_license=('Apache')
pkg_deps=('openssl')
pkg_build_deps=('git' 'clang' 'googletest')
# tags at 
pkg_source=("git+https://android.googlesource.com/platform/system/core#tag=android-${pkg_version}"
        "git+https://android.googlesource.com/platform/system/extras#tag=android-${pkg_version}"
        "git+https://android.googlesource.com/platform/external/libselinux#tag=android-${pkg_version}"
        "git+https://android.googlesource.com/platform/external/f2fs-tools#tag=android-$pkg_version"
        'build.patch'
        'build.sh') #keep in sync with ArchLinux build system for android-tools
pkg_shasum=('SKIP'
         'SKIP'
         'SKIP'
         'SKIP'
         '5b9cdd01ad9b1e1ccafb29113b34b34a'
         '2ed74aaefeea40e7e4d041384187c87f')

do_prepare() {
  patch -p1 -i ${CACHE_PATH}/build.patch
}         
         
do_build() {
  pkg_version=$pkg_version sh ./build.sh
}

do_package(){

  install -Dm 755 adb ${pkg_prefix}/usr/bin/adb
  install -Dm 755 fastboot ${pkg_prefix}/usr/bin/fastboot
  install -Dm 755 core/mkbootimg/mkbootimg ${pkg_prefix}/usr/bin/mkbootimg
}

