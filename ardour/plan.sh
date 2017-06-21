pkg_origin=

pkg_name=ardour
_pkg_name=Ardour
# adjust .desktop version!
pkg_version=5.10.0
pkg_description="A multichannel hard disk recorder and digital audio workstation"
pkg_upstream_url="http://ardour.org/"
pkg_license=('GPL')
pkg_deps=('qjackctl' 'desktop-file-utils')
pkg_source=("https://sourceforge.net/projects/kaosx/files/sources/ardour/${_pkg_name}-${pkg_version}-x86_64.run"
        'ardour.desktop')
pkg_shasum=('dda7d3abd005205efdee4378c85edd7d'
         '6346f62e0e10c3b064c86d75a690d02f')

do_build() {
  mkdir -p build
  sh ${_pkg_name}-${pkg_version}-x86_64.run --noexec --target build
}

do_package() {
  cd build

  install -d ${pkg_prefix}/opt
  bsdtar --no-same-owner -jxvf \
   ${_pkg_name}_x86_64-gcc5-${pkg_version}.tar \
    -C ${pkg_prefix}/opt

  install -Dm644 ${CACHE_PATH}/${pkg_name}.desktop ${pkg_prefix}/usr/share/applications/${pkg_name}.desktop
}
