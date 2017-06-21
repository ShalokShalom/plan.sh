pkg_origin=cosmos

pkg_name=hwids
pkg_version=20170328
_commit=6a43c39
pkg_description="Hardware identification databases"
pkg_upstream_url="https://github.com/gentoo/hwids"
pkg_license=('GPL2')
pkg_source=("https://github.com/gentoo/hwids/tarball/${pkg_name}-${pkg_version}")
pkg_shasum=('501a22132edaaf2377e6dd73c683dcf2')

do_package() {
  cd gentoo-${pkg_name}-${_commit}

  install -Dm644 usb.ids ${pkg_prefix}/usr/share/hwdata/usb.ids
  install -Dm644 pci.ids ${pkg_prefix}/usr/share/hwdata/pci.ids
}

