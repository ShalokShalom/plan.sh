pkg_origin=cosmos
pkg_name=bdf-unifont
pkg_version=5.1.20080820
pkg_description="GNU Unifont Glyphs"
pkg_license=('custom' 'GPL2')
pkg_upstream_url="http://unifoundry.com/unifont.html"
pkg_deps=('fontconfig' 'xorg-fonts-encodings' 'xorg-font-utils')
install=unifont.install
pkg_source=('http://unifoundry.com/unifont-5.1.20080820.bdf.gz'
        'LICENSE')
pkg_shasum=('6b8263ceccef33bd633aa019d74b7943'
         '64da5a96d6789d29d485cd67a43bc547')

do_package() {
  install -Dm644 ${CACHE_PATH}/unifont-5.1.20080820.bdf \
	${pkg_prefix}/usr/share/fonts/misc/unifont.bdf

  install -Dm644 ${CACHE_PATH}/LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}

