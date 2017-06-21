pkg_origin=

pkg_name=kodi
pkg_version=17.3
_pkg_version=17.3-Krypton
pkg_description="Open source (GPL) software media player and entertainment hub"
pkg_upstream_url="https://kodi.tv/"
pkg_license=('GPL' 'custom')
pkg_deps=( 'bzip2' 'curl' 'enca' 'faac' 'faad2' 'fontconfig' 'fribidi' 'python2' 'python-pysqlite'
          'glew' 'libcdio' 'libgl' 'libmad' 'libmms' 'libass' 'yajl' 'x264'
          'libmpeg2' 'libmariadbclient' 'libsamplerate' 'libpng' 'bluez'
          'libxrandr' 'libxtst' 'lzo2' 'sdl2' 'pulseaudio' 'libdvdcss'
          'samba' 'wavpack' 'mesa-demos' 'xorg-utils' 'libmicrohttpd' 'libjpeg-turbo' 'mesa' 'swig'
          'libssh' 'libva' 'libmodplug' 'lsb-release' 'sqlite3' 'libbluray' 'java-runtime'
          'tinyxml' 'taglib' 'libcap' 'glu' 'libusb' 'hicolor-icon-theme' 'libtiff' 'avahi'
          'gnutls' 'nettle' 'libnfs' 'dcadec' 'crossguid' 'python2-pillow' 'python2-simplejson' 'lcms2')
pkg_build_deps=('boost' 'cmake' 'gperf' 'nasm' 'libvdpau' 'zip' 'unzip' 'cmake'
             'doxygen' 'upower')
optpkg_deps=('unrar: access compressed files without unpacking them'
            'upower: used to trigger suspend functionality'
            'libvdpau: for nvidia hardware acceleration'
            'tk')
#pkg_source=("http://mirrors.xbmc.org/releases/source/xbmc-$pkg_version.tar.gz"
pkg_source=("https://github.com/xbmc/xbmc/archive/${_pkg_version}.tar.gz")
pkg_shasum=('8f1fec483beb40f1b302bd53ea399044')

do_build() {
    mkdir -p build
    cd build
    
    cmake ../xbmc-${_pkg_version}/project/cmake \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_INSTALL_LIBDIR=/usr/lib \
        -DENABLE_EVENTCLIENTS=OFF 
    make VERBOSE=1
  
    # use when switched to cmake build
    #make -C ../xbmc-${_pkg_version}/tools/depends/target/binary-addons PREFIX=/usr
}

do_package() {
    cd build

    make DESTDIR=${pkg_prefix} install

    # various fixes
    sed -i -e "s/lsb_release -a 2> \/dev\/null | sed -e 's\/\^\/    \/'/cat \/etc\/KaOS-release/g" ${pkg_prefix}/usr/bin/kodi

    # Licenses
    install -d -m 0755 ${pkg_prefix}/usr/share/licenses/${pkg_name}
    for licensef in LICENSE.GPL copying.txt; do
        mv ${pkg_prefix}/usr/share/doc/kodi/${licensef} ${pkg_prefix}/usr/share/licenses/${pkg_name}
    done
    
    # move from xbmc to kodi leaves conflicting symlinks in place of real files, pacman not handling it
    #rm -r ${pkg_prefix}/usr/share/xbmc
    #rm -r ${pkg_prefix}/usr/lib/xbmc
}
