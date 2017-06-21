pkg_origin=cosmos

pkg_name=startup-notification
pkg_version=0.12
pkg_description="Monitor and display application startup."
pkg_upstream_url="https://www.freedesktop.org"
pkg_license=('LGPL')
pkg_deps=('libx11' 'libsm' 'xcb-util')
pkg_source=("https://www.freedesktop.org/software/startup-notification/releases/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('2cd77326d4dcaed9a5a23a1232fb38e9')

do_build() {
  
  ./configure --prefix=/usr \
    --localstatedir=/var \
    --sysconfdir=/etc
    
  make
}

do_package() {
  
  make DESTDIR=${CACHE_PATH} install
}

