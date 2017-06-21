pkg_origin=cosmos

pkg_name=p11-kit
pkg_version=0.23.7
pkg_description="Library to work with PKCS#11 modules"
pkg_upstream_url="https://p11-glue.freedesktop.org"
pkg_license=('BSD')
pkg_deps=('glibc' 'libtasn1' 'libffi')
pkg_source=("https://github.com/p11-glue/p11-kit/releases/download/${pkg_version}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('ebbefd123210594231adb4bde21b8560')

do_build() {
  cd ${pkg_name}-${pkg_version}

  ./configure --prefix=/usr \
    --sysconfdir=/etc \
    --with-module-path=/usr/lib/pkcs11
  make
}

do_package() {
  cd  ${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix} install

  install -Dm644 COPYING $pkg_prefix/usr/share/licenses/${pkg_name}/COPYING
}
