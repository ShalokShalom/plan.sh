pkg_origin=cosmos

pkg_name=graphicsmagick
pkg_version=1.3.25
pkg_description="Image processing system"
pkg_upstream_url="http://www.graphicsmagick.org/"
pkg_license=('MIT')
pkg_deps=('bzip2' 'freetype2' 'ghostscript' 'jasper' 'lcms2' 'libsm' 'libpng' 'libxext'
        'libtiff' 'libxml2' 'libtool' 'xz' 'perl')
pkg_source=("http://downloads.sourceforge.net/project/graphicsmagick/${pkg_name}/${pkg_version}/GraphicsMagick-${pkg_version}.tar.xz")
pkg_shasum=('6eed966b22588fb068442319a8aa17f6')

do_build() {

  ./configure --prefix=/usr \
              --with-perl \
              --enable-shared \
              --with-modules \
              --with-wmf=no \
              --with-quantum-depth=16 \
              --with-gs-font-dir=/usr/share/fonts/Type1 
  make
  
  perl Makefile.PL INSTALLDIRS=vendor
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -Dm644 Copyright.txt ${pkg_prefix}/usr/share/licenses/$pkg_name/Copyright.txt 
  
  make DESTDIR=${pkg_prefix} install

  # Remove perllocal.pod and .packlist
  rm -rf ${pkg_prefix}/usr/lib/perl5/core_perl
  rm ${pkg_prefix}/usr/lib/perl5/vendor_perl/auto/Graphics/Magick/.packlist
}
