pkg_origin=cosmos

pkg_name=mutagen
pkg_version=1.38
pkg_description="An audio metadata tag reader and writer implemented in pure python"
pkg_upstream_url="https://mutagen.readthedocs.org/en/latest/"
pkg_license=('GPL2')
pkg_deps=('python2-setuptools')
pkg_source=("https://github.com/quodlibet/mutagen/releases/download/release-${pkg_version}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('c54443dfb8d4ac088eb2a0c4fd569772')

do_package() {
  
  python2 setup.py install --root=${pkg_prefix}
}
