pkg_origin=cosmos

pkg_name=lilv
pkg_version=0.24.2
pkg_description="A library to make the use of LV2 plugins as simple as possible for applications"
pkg_upstream_url="http://drobilla.net/software/lilv/"
pkg_license=('custom:ISC')
pkg_deps=('python2-numpy' 'sratom' 'jack')
pkg_build_deps=('swig')
pkg_source=("http://download.drobilla.net/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('cae7e1700f83b0f1272f437919a68458')

do_build() {
  sed -i "/ldconfig/d" wscript

  python2 waf configure --prefix=/usr \
                        --configdir=/etc \
                        --dyn-manifest \
                        --bindings

  python2 waf build $MAKEFLAGS
}

do_package() {

  python2 waf install --destdir=${pkg_prefix}

  install -Dm644 COPYING  ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}

