pkg_origin=cosmos

pkg_name=octave
pkg_version=4.2.1
pkg_description="A high-level language, primarily intended for numerical computations."
pkg_upstream_url="https://www.octave.org"
pkg_license=('GPL')
pkg_deps=('fftw' 'curl' 'graphicsmagick' 'glpk' 'hdf5' 'gcc-libs' 'qhull' 'fltk' 'libsndfile'
         'arpack' 'suitesparse' 'gperf' 'glu' 'gnuplot' 'gl2ps' 'ghostscript' 'qscintilla-qt5')
pkg_build_deps=('texlive-core' 'gcc-fortran' 'python2' 'qt5-tools')
pkg_source=("https://ftp.gnu.org/gnu/octave/octave-${pkg_version}.tar.lz")
pkg_shasum=('ca5106425e12df2bef23df72ba58f3c4')

do_build() {

  autoreconf -vfi

  ./configure --prefix=/usr \
       --libexecdir=/usr/lib \
       --enable-shared \
       --disable-static \
       --with-quantum-depth=16 \
       --with-umfpack="-lumfpack -lsuitesparseconfig" 

  LANG=C make
}

do_package(){

  make DESTDIR=${pkg_prefix} install

  # add path to ld.so.conf.d
  install -d ${pkg_prefix}/etc/ld.so.conf.d
  echo /usr/lib/${pkg_name}/${pkg_version} > ${pkg_prefix}/etc/ld.so.conf.d/${pkg_name}.conf
  # remove .desktop until ported to Qt 5
  #rm ${pkg_prefix}/usr/share/applications/www.octave.org-octave.desktop
}
