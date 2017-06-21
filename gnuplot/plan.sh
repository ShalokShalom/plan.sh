pkg_origin=cosmos

pkg_name=gnuplot 
pkg_version=5.0.6
pkg_description="Plotting package which outputs to X11, PostScript, PNG, GIF, and others" 
pkg_upstream_url="http://www.gnuplot.info" 
pkg_license=('custom') 
pkg_deps=('readline' 'gd' 'pango' 'libjpeg-turbo' 'qt5-svg' 'gnutls') 
pkg_build_deps=('texinfo' 'texlive-core' 'texlive-latexextra' 'qt5-tools') 
install=gnuplot.install 
pkg_source=("https://downloads.sourceforge.net/sourceforge/gnuplot/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('8ec46520a86a61163a701b00404faf1a')

do_build() {

  # adjust default source location 
  sed -i 's|/usr/X11R6/lib/X11/fonts/truetype|/usr/share/fonts/TTF|' src/variable.c
  sed -i -e 's|/usr/X11R6/lib/X11/fonts/Type1|/usr/share/fonts/Type1|' \
  -e 's|$(X11ROOT)/X11R6/lib/X11/fonts/Type1|$(X11ROOT)/usr/share/fonts/Type1|' \
  src/variable.c
  # glib 2.23 adjustment
  sed -i 's|isnan|std::isnan|' src/qtterminal/qt_conversion.cpp
  
  CXXFLAGS="-std=c++11"

  ./configure --prefix=/usr \
              --libexecdir=/usr/bin \
              --with-gihdir=/usr/share/gnuplot \
              --with-readline=gnu \
              --datadir=/usr/share \
              --without-lua \
              --with-qt=qt5
  make pkglibexecdir=/usr/bin
}


do_package() {
  make pkglibexecdir=/usr/bin DESTDIR=${pkg_prefix} install 

  install -Dm644 Copyright ${pkg_prefix}/usr/share/licenses/${pkg_name}/Copyright

  rm -f ${pkg_prefix}/usr/share/texmf-dist/ls-R
}
