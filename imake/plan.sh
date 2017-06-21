pkg_origin=cosmos

pkg_name=imake
pkg_version=1.0.7
pkg_description="X.Org imake program and related utilities"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('glibc')
pkg_build_deps=('pkg-config' 'xproto' 'perl')
pkg_deps=('perl:	for mkhtmlindex')
pkg_source=("http://xorg.freedesktop.org/releases/individual/util/imake-${pkg_version}.tar.bz2"
	"http://xorg.freedesktop.org/releases/individual/util/gccmakedep-1.0.3.tar.bz2"
	"http://xorg.freedesktop.org/releases/individual/util/lndir-1.0.3.tar.bz2"
	"http://xorg.freedesktop.org/releases/individual/util/makedepend-1.0.5.tar.bz2"
	"http://xorg.freedesktop.org/releases/individual/util/xorg-cf-files-1.0.5.tar.bz2"
	'linuxconfig.patch'
	'LICENSE')
pkg_shasum=('4042a4139a4636f78e2b8a144fdd1fcd'
         '683847bee13c78a005705824a7c6f225'
         'a47bcd6cecda1a6ebd3395926ea4f53a'
         '0475638eb40a3920d0d3f14482c924a4'
         '4a9cd7fc995ebf8f3cdad5395f9d8eba'
         'b3385d8efbbe7c7fc50ed3a96ce37a16'
         'f5767133ef7a98a0bfa15139e0e3d32e')

do_build() {
  patch -p1 -i "${CACHE_PATH}/linuxconfig.patch"
  for i in *; do
    if [ -d "${i}" ]; then
      pushd "${i}"
      ./configure --prefix=/usr --mandir=/usr/share/man
      make
      popd
    fi
  done
}

do_package() {
  for i in *; do
    if [ -d "${i}" ]; then
      pushd "${i}"
      make DESTDIR="${pkg_prefix}" install
      popd
    fi
  done
  install -D -m644 "${CACHE_PATH}/LICENSE" "${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE"
}

