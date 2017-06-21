pkg_origin=cosmos

pkg_name=mozilla-common
pkg_version=1.4
pkg_description="Common Initialization Profile for Mozilla.org products"
pkg_license=('GPL')
pkg_upstream_url="http://www.mozilla.org/"
install=mozilla-common.install
pkg_source=('mozilla-common.sh'
        'mozilla-common.csh')
pkg_shasum=('39451f6fe87d3cb224e140322c55eb27'
         '924887e41bd96db37029f479befe40cf')

do_package() {
  install -m755 -d ${pkg_prefix}/etc/profile.d
  install -m755 mozilla-common.{,c}sh ${pkg_prefix}/etc/profile.d/
}
