pkg_origin=cosmos

pkg_name=hardware-detection
pkg_version=20170509
pkg_description="Hardware detection scripts"
pkg_upstream_url="http://kaosx.us"
pkg_license=('GPL')
pkg_deps=('bc' 'util-linux' 'khd-nvidia' 'khd-nvidia-340xx' 'dmidecode') 
pkg_source=("git://github.com/KaOSx/hardware-detection.git")
pkg_shasum=('SKIP')

do_package(){

    make install DESTDIR=${pkg_prefix}
}
