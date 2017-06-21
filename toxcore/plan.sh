pkg_origin=

pkg_name=toxcore
pkg_version=0.1.9
pkg_description='Easy to use, all-in-one communication platform that ensures full privacy and secure message delivery.'
pkg_upstream_url='https://tox.chat'
pkg_license=('GPL3')
pkg_deps=('systemd' 'libconfig' 'libsndfile' 'libsodium' 'libvpx' 'opus' 'opencv' 'portaudio')
pkg_build_deps=('check' 'msgpack-c')
pkg_source=("https://github.com/TokTok/c-toxcore/archive/v${pkg_version}.tar.gz")
pkg_shasum=('f61ce9ec97064eb9ed3e2507818210b9')

do_build() {
  cd c-${pkg_name}-${pkg_version}
  
  ./autogen.sh
  ./configure \
    --prefix=/usr \
    --enable-tests \
    --enable-daemon
  make
}

do_check() {
  cd c-${pkg_name}-${pkg_version}
  # tox_test & toxav_basic_test fail
  make check 
}

do_package() {
  cd c-${pkg_name}-${pkg_version}
  
  make DESTDIR=${pkg_prefix} install
}

