pkg_origin=

pkg_name=lilypond
pkg_version=2.19.62
_pkg_version=2.19
pkg_description="A music engraving program, devoted to producing the highest-quality sheet music possible."
pkg_upstream_url="http://lilypond.org/"
pkg_license=('GPL')
pkg_deps=('fontconfig' 'freetype2' 'ghostscript' 'guile1.8' 'pango' 'python2' 'texlive-core'
         'tex-gyre-fonts')
pkg_build_deps=('bison' 'flex' 'fontforge' 'gettext' 'gsfonts' 'perl' 'texinfo' 't1utils'
             'netpbm' 'zip' 'imagemagick' 'rsync')
optpkg_deps=('netpbm: building HTML documentation'
            'imagemagick: building HTML documentation'
            'rsync: installing HTML documentation')
pkg_source=("http://download.linuxaudio.org/lilypond/sources/v${_pkg_version}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('501bb42fa91c823bb7d2e3416ca49784')


do_build() {
  cd ${pkg_name}-${pkg_version}
  
  sed -i 's|GUILE_CFLAGS=.*|GUILE_CFLAGS="`pkg-config --cflags guile-1.8`"|' configure
  sed -i 's|GUILE_LDFLAGS=.*|GUILE_LDFLAGS="`pkg-config --libs guile-1.8`"|' configure
  
  export GUILE=/usr/bin/guile1.8
  export GUILE_CONFIG=/usr/bin/guile-config1.8
  export LDFLAGS="$LDFLAGS -lpthread"

  ./configure --prefix=/usr --disable-documentation
  make all
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  
  make DESTDIR=${pkg_prefix}/ install
}
