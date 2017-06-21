pkg_origin=cosmos

pkg_name=r
pkg_version=3.4.0
pkg_description="Language and environment for statistical computing and graphics"
pkg_license=('GPL')
pkg_upstream_url="https://www.r-project.org/"
pkg_deps=('lapack' 'bzip2'  'libpng' 'libjpeg' 'libtiff' 'icu'
         'ncurses' 'pcre' 'readline' 'zlib' 'perl' 'gcc-libs' 'zip' 'unzip'
         'tk' 'libxt' 'libxmu' 'pango' 'xz' 'desktop-file-utils')
pkg_build_deps=('openjdk' 'gcc-fortran')
backup=('etc/R/Makeconf' 'etc/R/Renviron' 'etc/R/ldpaths' 'etc/R/repositories')
pkg_source=("https://cran.r-project.org/src/base/R-3/R-${pkg_version}.tar.gz"
        'r.desktop'
        'r.png'
        'R.conf')
pkg_shasum=('75083c23d507b9c16d5c6afbd7a827e7'
         'f6d54d32e510d90c748a0d16d2abcbdc'
         '00659f39e90627fe87f1645df5d4e3a7'
         '1dfa62c812aed9642f6e4ac34999b9fe')

do_build() {
   sed -i 's|$(rsharedir)/texmf|${datarootdir}/texmf|' share/Makefile.in
   sed -i 's|test ${makeinfo_version_min} -lt 7|test ${makeinfo_version_min} -lt 0|' configure
   sed -i 's|ZLIB_VERSION, "1.2.5", 5|ZLIB_VERSION, "1.2.1", 6|' configure
   
   ./configure  --prefix=/usr \
        --libdir=/usr/lib \
        --sysconfdir=/etc/R \
        --datarootdir=/usr/share \
            rsharedir=/usr/share/R/ \
            rincludedir=/usr/include/R/ \
            rdocdir=/usr/share/doc/R/ \
        --with-x \
        --enable-R-shlib \
        --with-lapack \
        --with-blas \
        F77=gfortran \
        LIBnn=lib
   make
   
   make shared
}

do_package() {
   make -j1 DESTDIR=${CACHE_PATH} install
   
   make DESTDIR=${CACHE_PATH} install

   # R wrapper scripts.
   sed -i "s|${CACHE_PATH} ||" ${CACHE_PATH}/usr/bin/R
   rm ${CACHE_PATH}/usr/lib/R/bin/R
   ln -s ../../../bin/R

  install -Dm644 ${CACHE_PATH}/r.desktop ${CACHE_PATH}/usr/share/applications/r.desktop
  install -Dm644 ${CACHE_PATH}/r.png ${CACHE_PATH}/usr/share/pixmaps/r.png

  install -d ${CACHE_PATH}/etc/R
  for i in *; do
    mv -f ${i} ${CACHE_PATH}/etc/R
    ln -s /etc/R/${i} ${i}
  done
  
  install -Dm644 ${CACHE_PATH}/R.conf ${CACHE_PATH}/etc/ld.so.conf.d/R.conf
}
