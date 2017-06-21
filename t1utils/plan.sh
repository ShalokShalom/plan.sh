pkg_origin=cosmos

pkg_name=t1utils
pkg_version=1.39
pkg_description="Collection of simple Type 1 font manipulation programs"
pkg_upstream_url="https://www.lcdf.org/~eddietwo/type/#t1utils"
pkg_license=("custom")
pkg_deps=('glibc')
pkg_source=("https://www.lcdf.org/~eddietwo/type/${pkg_name}-${pkg_version}.tar.gz"
        'LICENSE')
pkg_shasum=('88837df02d69ed9d0f61c44ce5049cf4'
         '5a1334c824d21f0314c831f9fd19a587')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install
  
  install -D -m644 ../LICENSE ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
