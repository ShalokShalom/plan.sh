pkg_origin=cosmos

pkg_name=json-c
pkg_version=0.12.1
_pkg_version=0.12.1-20160607
pkg_description="JSON-C implements a reference counting object model that allows you to easily construct JSON objects in C, output them as JSON formatted strings and parse JSON formatted strings back into the C representation of JSON objects."
pkg_upstream_url="https://github.com/json-c/json-c/wiki"
pkg_license=('MIT')
#pkg_source=("https://s3.amazonaws.com/json-c_releases/releases/$pkg_name-$pkg_version.tar.gz"
pkg_source=("https://github.com/json-c/json-c/archive/json-c-${_pkg_version}.tar.gz")
pkg_shasum=('0a2a49a1e89044fdac414f984f3f81a6')

do_build() {

  ./autogen.sh
  ./configure --prefix=/usr --disable-static
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -Dm644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/COPYING
}

