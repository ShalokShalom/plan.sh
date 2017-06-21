pkg_origin=cosmos

pkg_name=pm-quirks
_date=20100619
pkg_version=0.${_date}
pkg_description="Quirks data for pm-utils"
pkg_license=('GPL')
pkg_upstream_url="http://pm-utils.freedesktop.org/wiki/"
pkg_source=("http://pm-utils.freedesktop.org/releases/${pkg_name}-${_date}.tar.gz")
pkg_shasum=('3b6ee39056b9ece0cd5e073a4c272b05')

do_package() {
  install -m755 -d ${pkg_prefix}/usr/lib/pm-utils/video-quirks
  install -m644 video-quirks/*.quirkdb ${pkg_prefix}/usr/lib/pm-utils/video-quirks/
}
