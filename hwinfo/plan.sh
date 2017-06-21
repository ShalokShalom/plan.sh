pkg_origin=cosmos

pkg_name=hwinfo
pkg_version=21.45
_minorver=1.1
pkg_description="Simple program that lists results from the hardware detection library."
pkg_upstream_url="https://github.com/openSUSE/hwinfo"
pkg_license=('GPL2')
pkg_deps=('perl' 'libx86emu')
pkg_build_deps=('sysfsutils' 'rpmextract' 'flex')
pkg_source=("https://download.opensuse.org/source/tumbleweed/repo/oss/suse/src/${pkg_name}-${pkg_version}-${_minorver}.src.rpm"
        "kbd.patch")
pkg_shasum=('7a17a1dffe8258856a1fa3d84082000a'
         '1500ecfa26f6aaf4d7967eea74e86e5d')

do_build() {

  rpmextract.sh ${pkg_name}-${pkg_version}-${_minorver}.src.rpm
  tar -xJf ${pkg_name}-${pkg_version}.tar.xz

  patch -p0 -i ${CACHE_PATH}/kbd.patch 
  
  make -j1 CFLAGS+="-fPIC -I${CACHE_PATH}/${pkg_name}-${pkg_version}/src/hd" LIBDIR=/usr/lib
}

do_package() {

  make LIBDIR=/usr/lib DESTDIR=${pkg_prefix} install
}
