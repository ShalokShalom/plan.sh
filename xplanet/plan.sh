pkg_origin=cosmos

pkg_name=xplanet
pkg_version=1.3.1
pkg_description="Xplanet was inspired by Xearth, which renders an image of the earth into the X root window"
pkg_upstream_url="http://xplanet.sourceforge.net/"
pkg_license=('GPL')
pkg_deps=('pango' 'giflib' 'libtiff' 'perl' 'libxss')
pkg_source=("http://downloads.sourceforge.net/project/xplanet/xplanet/$pkg_version/${pkg_name}-${pkg_version}.tar.gz"
        'giflib.patch')
pkg_shasum=('9797dbd9697d10205ca1671f728ea30d'
         '4ccddbd3edfae97a8d4cf36ea571282f')

do_build() {
  patch -p1 -i ${CACHE_PATH}/giflib.patch

  ./configure --prefix=/usr --with-freetype
  make
}

do_package() {
  
  make prefix=${CACHE_PATH}/usr install
}
