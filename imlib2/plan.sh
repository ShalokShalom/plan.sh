pkg_origin=cosmos

pkg_name=imlib2
pkg_version=1.4.10
pkg_description="Library that does image file loading and saving as well as rendering, manipulation, arbitrary polygon support"
pkg_upstream_url="https://sourceforge.net/projects/enlightenment/"
pkg_license=('BSD')
pkg_deps=('libtiff' 'giflib' 'bzip2' 'freetype2' 'libxext' 'libpng' 'libid3tag' 'libjpeg-turbo')
pkg_source=("https://downloads.sourceforge.net/enlightenment/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('a0de8524592bbd9f24fcc6cb8352137c')

do_build() {
  #patch -p1 -i $CACHE_PATH/giflib51.patch

  ./configure --prefix=/usr \
              --sysconfdir=/etc/imlib2 \
              --x-libraries=/usr/lib \
              --enable-amd64
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -Dm644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/COPYING
}
