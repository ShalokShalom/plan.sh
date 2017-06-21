pkg_origin=

pkg_name=wine
pkg_version=2.10
_pkg_version=2.10
pkg_description="Compatibility layer capable of running Windows applications on several POSIX-compliant operating systems."
pkg_upstream_url="https://www.winehq.com"
pkg_license=('LGPL')
pkg_deps=('fontconfig' 'glu' 'libxcursor' 'libxrandr' 'libxdamage' 'libxxf86dga' 'alsa-lib' 
         'desktop-file-utils' 'giflib' 'libpng' 'libxml2' 'libldap' 'lcms2' 'openal' 'jack'
         'cups' 'gnutls' 'v4l-utils' 'libjpeg-turbo' 'mpg123' 'libxinerama' 'libxslt'
         'ncurses' 'libcl' 'libxcomposite' 'alsa-plugins' 'samba' 'gst-plugins-base' 'pulseaudio'
         'gsm' 'sane' 'libgphoto2' 'opencl-headers')
pkg_build_deps=('autoconf' 'perl' 'fontforge' 'flex' 'libxpm' 'libxmu')
install=wine.install
pkg_source=("https://sourceforge.net/projects/wine/files/Source/${pkg_name}-${_pkg_version}.tar.xz")
pkg_shasum=('6f0798c73752ad22a1a3d69c49157e31')

do_build() {
    mkdir -p build
    cd build

    ../${pkg_name}-${_pkg_version}/configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --libdir=/usr/lib \
        --with-x \
        --with-gstreamer \
        --enable-win64

    make
}

do_package() {
    cd build
    make prefix=${pkg_prefix}/usr libdir=${pkg_prefix}/usr/lib dlldir=${pkg_prefix}/usr/lib/wine install
    
    sed -i -e 's|wine start /unix %f|wine64 start /unix %f|' ${pkg_prefix}/usr/share/applications/wine.desktop
}


