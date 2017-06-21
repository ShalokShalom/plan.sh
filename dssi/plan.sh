pkg_origin=cosmos

pkg_name=dssi
pkg_version=1.1.1
pkg_description="API for audio plugins, with particular application for software synthesis plugins with native user interfaces."
pkg_upstream_url="http://dssi.sourceforge.net/"
pkg_license=('LGPL' 'BSD' 'custom')
pkg_deps=('gcc-libs' 'liblo' 'jack' 'libsamplerate' 'libx11')
pkg_build_deps=('ladspa' 'pkgconfig')
pkg_source=("http://downloads.sourceforge.net/dssi/${pkg_name}-${pkg_version}.tar.gz"
        'LICENSE')
pkg_shasum=('619ab73c883b02dc37ddb37001591f8b'
        '258ca4d0ca28c5c4d4675147621fac18')

do_build() {
  
  ./configure --prefix=/usr 
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -Dm644 ${CACHE_PATH}/LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
