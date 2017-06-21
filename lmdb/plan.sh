pkg_origin=cosmos

pkg_name=lmdb
pkg_version=0.9.21
pkg_description="Fast, ultra-compact key-value embedded data store developed by Symas for the OpenLDAP Project."
pkg_upstream_url="http://symas.com/mdb"
pkg_license=('custom:OpenLDAP')
pkg_deps=('gcc')
pkg_source=("https://github.com/LMDB/lmdb/archive/LMDB_${pkg_version}.tar.gz")
pkg_shasum=('41a4f7b63212a00e53fabd8159008201')

do_build() {

  make prefix=/usr
}

do_package() {
  install -m755 -d ${pkg_prefix}/usr/{bin,lib,include,man/man1,share}
  
  make DESTDIR=${pkg_prefix} prefix=/usr install
  mv $pkg_prefix/usr/man $pkg_prefix/usr/share/man
  install -m644 -D LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
