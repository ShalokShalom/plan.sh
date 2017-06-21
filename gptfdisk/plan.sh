pkg_origin=cosmos

pkg_name=gptfdisk
pkg_version=1.0.1
pkg_description="Text-mode partitioning tool that works on Globally Unique Identifier (GUID) Partition Table (GPT) disks"
pkg_upstream_url="http://www.rodsbooks.com/gdisk/"
pkg_license=('GPL2')
pkg_deps=('gcc-libs' 'util-linux' 'popt' 'icu')
pkg_source=("http://downloads.sourceforge.net/project/gptfdisk/${pkg_name}/${pkg_version}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('d7f3d306b083123bcc6f5941efade586')

do_build() {

  make
}

package () {

  install -d $pkg_prefix/usr/{bin,share/{doc/gdisk,man/man8}}
  install -t $pkg_prefix/usr/bin {,c,s}gdisk fixparts
  install -m644 -t $pkg_prefix/usr/share/man/man8 {{,c,s}gdisk,fixparts}.8
  install -m644 -t $pkg_prefix/usr/share/doc/gdisk README NEWS
}
