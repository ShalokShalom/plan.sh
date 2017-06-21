pkg_origin=

pkg_name=qwinff
pkg_version=0.2.1
pkg_description="Cross-platform, easy-to-use and open-source media converter GUI using FFmpeg as its backend."
pkg_upstream_url="http://qwinff.github.io/"
pkg_license=('GPL3')
pkg_deps=('qt5-base' 'ffmpeg' 'sox')
pkg_build_deps=('cmake')
pkg_source=("https://sourceforge.net/projects/qwinff/files/release/v${pkg_version}/${pkg_name}_${pkg_version}.tar.bz2")
pkg_shasum=('4237a66cd2ceef658a30f17010d31490')

do_build() {
   cd ${pkg_name}-${pkg_version}

   make PREFIX=/usr QMAKE=/usr/lib/qt5/bin/qmake LRELEASE=/usr/lib/qt5/bin/lrelease
}

do_package() {
   cd ${pkg_name}-${pkg_version}

   make DESTDIR=${pkg_prefix} install
}
