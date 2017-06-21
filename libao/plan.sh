pkg_origin=cosmos

pkg_name=libao
pkg_version=1.2.2
pkg_description="A cross-platform audio output library and plugins"
pkg_upstream_url="http://www.xiph.org/ao"
pkg_license=('GPL')
pkg_deps=('glibc' 'alsa-lib' 'pulseaudio')
backup=('etc/libao.conf')
#pkg_source=("http://downloads.xiph.org/releases/ao/${pkg_name}-${pkg_version}.tar.gz"
pkg_source=("https://github.com/xiph/libao/archive/${pkg_version}.tar.gz"
        'libao.conf')
pkg_shasum=('71a9f8366718036e90954e4f0a4030e0'
         '9fc7db4ee6d5e9d1747333f7d4cce4a1')

do_build() {

  ./autogen.sh
  ./configure --prefix=/usr \
              --enable-alsa-mmap \
              --enable-pulse \
              --disable-nas
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install 

  install -Dm0644 ${CACHE_PATH}/libao.conf ${pkg_prefix}/etc/libao.conf
}
