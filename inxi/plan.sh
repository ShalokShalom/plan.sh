pkg_origin=

pkg_name=inxi
pkg_version=2.3.17
_commit=fc37703da601c7ae96fa111c366841830c3ccafe
pkg_description="Script to get system information"
pkg_upstream_url="http://smxi.org/docs/inxi.htm"
pkg_license=('GPL')
pkg_deps=('mesa-demos' 'coreutils' 'gawk' 'grep' 'pciutils' 'procps-ng' 'sed' 'dmidecode')
pkg_source=("https://github.com/smxi/inxi/archive/${_commit}.zip")
pkg_shasum=('bfd0974d8d779b0056d57f7c95f20501')

do_package() {
  cd ${pkg_name}-${_commit}
  
  install -D -m755 inxi ${pkg_prefix}/usr/bin/inxi
  install -D -m755 inxi.1.gz ${pkg_prefix}/usr/share/man/man1/inxi.1.gz
}

