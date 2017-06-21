pkg_origin=cosmos

pkg_name=libfakekey
pkg_version=0.1
pkg_description='X virtual keyboard library.'
pkg_upstream_url='http://matchbox-project.org/'
pkg_license=('GPL')
pkg_deps=('libxtst')
pkg_source=("http://downloads.yoctoproject.org/releases/matchbox/libfakekey/${pkg_version}/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('83dbde4d77e8baf0176fe4291d8a2303')

do_build() {

  ./configure --prefix=/usr \
        --sysconfdir=/etc \
        --localstatedir=/var \
        --disable-static 
        
  make AM_LDFLAGS=-lX11
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
