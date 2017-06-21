pkg_origin=cosmos

pkg_name=maxima
pkg_version=5.40.0
pkg_description="Maxima - a sophisticated Computer Algebra System."
pkg_license=('GPL')
pkg_upstream_url="http://maxima.sourceforge.net"
pkg_deps=('sbcl=1.3.18' 'texinfo' 'sh')
pkg_deps=('gnuplot: plotting capabilities' \
            'tk: graphical xmaxima interface')
# needs rebuild when bash changes version
pkg_source=("https://sourceforge.net/projects/maxima/files/Maxima-source/${pkg_version}-source/${pkg_name}-${pkg_version}.tar.gz"
        "${pkg_name}.desktop")
pkg_shasum=('1b7d3b4f7dfc5eae2fcf79e8987f5f23'
         '24aa81126fbb8b726854e5a80d4c2415')

do_build() {

  ./configure --prefix=/usr \
              --mandir=/usr/share/man \
              --infodir=/usr/share/info \
              --libexecdir=/usr/lib \
              --enable-sbcl \
              --with-default-lisp=sbcl

  touch doc/info/maxima.info
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -Dm644 ${CACHE_PATH}/${pkg_name}.desktop ${pkg_prefix}/usr/share/applications/${pkg_name}.desktop

  install -d ${pkg_prefix}/usr/share/pixmaps
  ln -s /usr/share/maxima/${pkg_version}/xmaxima/maxima-new.png ${pkg_prefix}/usr/share/pixmaps/${pkg_name}.png
}
