pkg_origin=cosmos

pkg_name=harfbuzz
pkg_version=1.4.6
pkg_description="OpenType text shaping engine."
pkg_upstream_url="https://www.freedesktop.org/wiki/Software/HarfBuzz"
pkg_license=('MIT')
pkg_deps=('icu' 'glib2' 'freetype2' 'graphite')
pkg_build_deps=('cairo')
pkg_deps=('cairo: hb-view program')
pkg_source=("https://www.freedesktop.org/software/harfbuzz/release/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('e246c08a3bac98e31e731b2a1bf97edf')

do_build() {

  ./configure --prefix=/usr \
        --with-glib \
        --with-freetype \
        --with-cairo \
        --with-icu \
        --with-graphite2
  make
}

do_package() {

  make DESTDIR=${pkg_prefix} install
  install -Dm644 COPYING ${pkg_prefix}/usr/share/licenses/harfbuzz/COPYING
}
