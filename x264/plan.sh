pkg_origin=cosmos

pkg_name=x264
pkg_version=20170522
pkg_description="Library and application for encoding video streams into the H.264/MPEG-4 AVC"
pkg_upstream_url="https://www.videolan.org/developers/x264.html"
pkg_license=('GPL')
pkg_deps=('glibc')
pkg_build_deps=('yasm' 'libvpx>=1.1.0')
pkg_source=("https://download.videolan.org/pub/videolan/x264/snapshots/x264-snapshot-${pkg_version}-2245-stable.tar.bz2")
pkg_shasum=('8dd0d12b5c233edf074224f40f6f6f1c')

do_build() {

    ./configure --prefix=/usr --enable-shared --enable-pic

    make
}
do_package() {

    make DESTDIR=${CACHE_PATH} install
}
