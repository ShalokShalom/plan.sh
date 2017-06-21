pkg_origin=cosmos

pkg_name=alsa-firmware
pkg_version=1.0.29
pkg_description="ALSA firmware package"
pkg_upstream_url="https://alsa-project.org/"
pkg_license=('GPL')
pkg_source=("ftp://ftp.alsa-project.org/pub/firmware/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('9a1182f8a6ac44cb9af5774cc045565f')

do_build() {
  
  ./configure --prefix=/usr --with-hotplug-dir=/usr/lib/firmware
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  # conflicts with linux-firmware
  rm -rf ${pkg_prefix}/usr/lib/firmware/{ct{efx,speq}.bin,ess,korg,sb16,yamaha}
  # remove broken symlinks (broken upstream)
  rm -rf ${pkg_prefix}/usr/lib/firmware/turtlebeach
  # remove empty dir
  rm -rf ${pkg_prefix}/usr/bin
}
