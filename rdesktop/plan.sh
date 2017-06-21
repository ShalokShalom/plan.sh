pkg_origin=cosmos

pkg_name=rdesktop
pkg_version=1.8.3
_commit=7d8675074f99f30727403d69c51f440f24a2b024
pkg_description="Open source UNIX client for connecting to Windows Remote Desktop Services"
pkg_upstream_url="http://www.rdesktop.org/"
pkg_license=('GPL')
pkg_deps=('libx11' 'openssl' 'libao' 'libsamplerate' 'xorg-server-utils' 'pcsclite')
pkg_source=("https://github.com/rdesktop/rdesktop/archive/${_commit}.zip")
pkg_shasum=('a6039f40f2840170e2cf3579ff7853b9')

do_build() {

  ./bootstrap
  ./configure --prefix=/usr \
    --enable-smartcard \
    --with-ipv6
  make
}

do_package() {
  
  make DESTDIR=${CACHE_PATH} install
}

