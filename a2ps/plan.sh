pkg_origin=cosmos

pkg_name=a2ps
pkg_version=4.14
pkg_description="An Any to PostScript filter"
pkg_upstream_url="http://www.gnu.org/software/a2ps/"
pkg_license=('GPL3')
pkg_deps=('ghostscript' 'psutils' 'imagemagick')
pkg_build_deps=('gperf')
backup=('etc/a2ps/a2ps.cfg' 'etc/a2ps/a2ps-site.cfg')
install=a2ps.install
pkg_source=("ftp://ftp.gnu.org/gnu/a2ps/${pkg_name}-${pkg_version}.tar.gz"
        'a2ps-4.13c-fnmatch-replacement.patch'
        'a2ps-4.13c-emacs.patch' 
	'a2ps-4.13-manpage-chmod.patch'
	'a2ps-4.14-check-mempcpy.patch' 
	'a2ps-4.14-fix-stpcpy-proto.patch'
	'a2ps-texinfo5.patch'
	'security.patch')
pkg_shasum=('781ac3d9b213fa3e1ed0d79f986dc8c7'
         '93011b58e9f20a7fafa31287a51884a4'
         '2e493d0bc00d71eb3e8a9b6febc52b69'
         '09cc5ed4d3d8ff1b2103e519191e8286'
         '42aa39b74f6da8cf6e94185c4fc3e601'
         '066f9327fee6b6eca3a57d657d1097d1'
         'f8464790224d6f5444ac8ce3cfce8e8c'
         'fa3c5f09f47619fbee347256e940fcce')

do_prepare() {
  sed -i -e '/^AM_C_PROTOTYPES/d' -e '/^AUTOMAKE_OPTIONS.*ansi2knr/d' \
    -e 's:AM_CONFIG_HEADER:AC_CONFIG_HEADERS:' -e 's:AM_PROG_CC_STDC:AC_PROG_CC:' \
    configure.in {contrib/sample,lib,src}/Makefile.am m4/protos.m4
  sed -i "s:^countdictstack: \0:" contrib/psset.in
  
  patch -p1 -i "${CACHE_PATH}/a2ps-4.13c-fnmatch-replacement.patch"
  patch -p1 -i "${CACHE_PATH}/a2ps-4.13c-emacs.patch"
  patch -p1 -i "${CACHE_PATH}/a2ps-4.13-manpage-chmod.patch"
  patch -p1 -i "${CACHE_PATH}/a2ps-4.14-check-mempcpy.patch"
  patch -p0 -i "${CACHE_PATH}/a2ps-4.14-fix-stpcpy-proto.patch"
  patch -p1 -i "${CACHE_PATH}/a2ps-texinfo5.patch"
  patch -p1 -i "${CACHE_PATH}/security.patch"
}

do_build() {
  libtoolize --force --copy
  autoreconf --force --install -I m4 
  
  LIBS+="-lm" ./configure --prefix=/usr \
       --sysconfdir=/etc/a2ps \
       --includedir=/usr/include \
       --enable-shared \
       --enable-nls
  make
}

do_package() {
  
  make DESTDIR="${pkg_prefix}" install
}
