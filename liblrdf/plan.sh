pkg_origin=cosmos

pkg_name=liblrdf
pkg_version=0.5.0
pkg_description="A library for the manipulation of RDF file in LADSPA plugins"
pkg_upstream_url="https://github.com/swh/LRDF"
pkg_deps=('raptor' 'ladspa')
pkg_build_deps=('pkgconfig')
pkg_license=('GPL')
pkg_source=("https://github.com/swh/LRDF/tarball/${pkg_version}")
groups=('ladspa-plugins')
pkg_shasum=('005ea24152620da7f2ee80a78e17f784')

do_build() {

  autoreconf -vfi
  ./configure --prefix=/usr \
              --disable-static
  make
}

do_package() {
  
  make DESTDIR="${pkg_prefix}" install
}
