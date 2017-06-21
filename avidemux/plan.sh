pkg_origin=

pkg_name=avidemux
pkg_version=2.6.20
_commit=ed7aa6bdbffc43a2cd198130a353b088abd02aa0
pkg_description="Video editor designed for simple cutting, filtering and encoding tasks using a variety of codecs."
pkg_upstream_url="http://fixounet.free.fr/avidemux/"
pkg_license=('Public Domain')
pkg_deps=('qt5-script' 'flac' 'libva' 'libxv' 'desktop-file-utils' 'x264' 'pulseaudio' 'jack'
         'lame' 'sqlite' 'libvpx' 'x265' 'faac' 'faad2' 'fribidi' 'glu' 'libdca' 'opencore-amr'
         'xvidcore')
pkg_build_deps=('cmake' 'yasm' 'pkg-config' 'qt5-tools')
pkg_source=("https://downloads.sourceforge.net/avidemux/avidemux_${pkg_version}.tar.gz"
#pkg_source=("https://github.com/mean00/avidemux2/archive/${_commit}.zip"
        'bootStrap.diff')
pkg_shasum=('52be64ae608c9195454b5393ba684fc0'
         'fb9c8caa824dd013cedcabe90aab37f9')

do_prepare() {
    cd ${pkg_name}_${pkg_version}
    # try to disable vdpau, build fails on vdpau, workaround, remove libvdpau from chroot
    #sed 's|SET(USE_VDPAU 1)|#SET(USE_VDPAU 1)|g' -i cmake/admCheckVDPAU.cmake
    patch -p1 -i $CACHE_PATH/bootStrap.diff
}

do_build() {
    cd ${pkg_name}_${pkg_version}
    bash bootStrap.bash --with-core \
        --with-plugins 
}

do_package() {
    cd ${pkg_name}_${pkg_version}
    cp -r install/usr/ ${pkg_prefix}/

    install -Dm644 ${pkg_name}_icon.png ${pkg_prefix}/usr/share/pixmaps/${pkg_name}.png
    install -Dm644 ${pkg_name}2.desktop ${pkg_prefix}/usr/share/applications/${pkg_name}.desktop
    sed 's|Exec=avidemux2_gtk|Exec=avidemux3_qt5|' -i ${pkg_prefix}/usr/share/applications/${pkg_name}.desktop
}
