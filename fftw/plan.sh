pkg_origin=cosmos

pkg_name=fftw
pkg_version=3.3.6
_pkg_version=3.3.6-pl2
pkg_description="A library for computing the discrete Fourier transform (DFT)"
pkg_license=('GPL2')
pkg_upstream_url="http://www.fftw.org/"
pkg_deps=('glibc' 'bash')
pkg_source=("http://www.fftw.org/${pkg_name}-${_pkg_version}.tar.gz")
pkg_shasum=('927e481edbb32575397eb3d62535a856')

# notes:
# http://www.fftw.org/fftw2_doc/fftw_6.html#SEC69
# http://www.fftw.org/faq/section2.html#singleprec
# http://www.fftw.org/fftw3_doc/Precision.html#Precision

do_build() {
  
  cp -a ${pkg_name}-${_pkg_version} ${pkg_name}-${pkg_version}-double
  cp -a ${pkg_name}-${_pkg_version} ${pkg_name}-${pkg_version}-long-double
  mv ${pkg_name}-${_pkg_version} ${pkg_name}-${pkg_version}-single
  
  CFLAGS+=" -O3 -fomit-frame-pointer -malign-double -fstrict-aliasing -ffast-math"

  CONFIGURE="./configure F77=gfortran --prefix=/usr --enable-shared --enable-threads"

  # build double precision
  $CONFIGURE --enable-sse2
  make

  # build & install long double precission
  $CONFIGURE --enable-long-double
  make

  # build & install single precision
  $CONFIGURE --enable-float --enable-sse
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  make DESTDIR=${pkg_prefix} install

  make DESTDIR=${pkg_prefix} install  
}
