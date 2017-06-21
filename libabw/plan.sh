pkg_origin=cosmos

pkg_name=libabw
pkg_version=0.1.1
pkg_description="Libabw is library providing ability to interpret and import AbiWord documents into various applications."
pkg_upstream_url="http://www.freedesktop.org/wiki/Software/libabw/"
pkg_license=('MPL2')
pkg_deps=('libwpd' 'libwpg' 'glib2' 'libgsf' 'gperf' 'librevenge')  
pkg_build_deps=('boost')
pkg_source=("http://dev-www.libreoffice.org/src/libabw/${pkg_name}-${pkg_version}.tar.xz"
        "https://github.com/LibreOffice/libabw/commit/ee2d0729315888d1847587ad556470d2fdc883a7.diff")
pkg_shasum=('6be55a46078b593ec20cad9bb8730c3e'
         'bbcdfafc2d5387eadf586fad2981d34c')

do_build() {
  # boost 1.60 needed patch
  patch -p1 -i ${CACHE_PATH}/ee2d0729315888d1847587ad556470d2fdc883a7.diff

  ./autogen.sh
  ./configure --without-docs --enable-static=no --prefix=/usr
  make
}

do_package() {

  make DESTDIR=${pkg_prefix} install
}
