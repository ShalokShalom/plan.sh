pkg_origin=

pkg_name=freerdp
_pkg_name=FreeRDP
pkg_version=2.0.0beta
#_pkg_version=1.2.0-beta1-android9
_commit=5b2455f3147aca395a441fc65b602938600f0788
pkg_description="Free RDP client"
pkg_upstream_url="http://www.freerdp.com/"
pkg_license=('GPL')
pkg_deps=('openssl' 'libxcursor' 'libcups' 'alsa-lib' 'libxext' 'libxdamage'
        'ffmpeg' 'libxkbfile' 'libxinerama' 'libxv' 'pulseaudio' 'libxrender' 
        'libxfixes' 'gst-plugins-base' 'libxkbcommon' 'libxrandr') 
pkg_build_deps=('krb5' 'cmake' 'damageproto' 'xmlto' 'docbook-xsl')
pkg_source=("https://github.com/FreeRDP/FreeRDP/archive/${_commit}.zip")
pkg_shasum=('02b6b125b31950a536ab61e1775fbe1c')

do_build() {
  mkdir build
  cd build
  
  cmake ../${_pkg_name}-${_commit} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DWITH_GSTREAMER_1_0=ON \
    -DWITH_PULSE=ON \
    -DWITH_CUPS=ON
  make
}

do_package() {
  cd build
  
  make DESTDIR=$pkg_prefix install
}
