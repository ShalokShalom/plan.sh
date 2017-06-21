pkg_origin=cosmos

pkg_name=pam_encfs
pkg_version=0.1.4.4
pkg_description="Module to auto mount encfs dir on login"
pkg_upstream_url="http://code.google.com/p/pam-encfs/"
pkg_deps=('encfs')
backup=('etc/security/pam_encfs.conf')
pkg_license="GPL"
pkg_source=("https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/pam-encfs/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('20d10fa842e968a224af542db7e10d21')

do_build() {

  make 
}

do_package() {
  make DESTDIR=${pkg_prefix}/usr install 

  mkdir -p ${pkg_prefix}/etc/security
  cp pam_encfs.conf ${pkg_prefix}/etc/security
}

