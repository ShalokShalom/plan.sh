pkg_origin=cosmos

pkg_name=crypto++
pkg_version=5.6.5
_pkg_version=5_6_5
pkg_description="A free C++ class library of cryptographic schemes."
pkg_license=('custom')
pkg_build_deps=('unzip' 'cmake')
pkg_upstream_url="http://www.cryptopp.com/"
pkg_source=("https://github.com/weidai11/cryptopp/archive/CRYPTOPP_${_pkg_version}.tar.gz"
        'libcrypto++.pc') # set to remove after testing cmake build setup, needed for clementine
pkg_shasum=('88224d9c0322f63aa1fb5b8ae78170f0'
         'ea27f28fe0303fcaa24d83cf4a964d53')

do_build() {
  mkdir -p build
  
  cmake ../cryptopp-CRYPTOPP_${_pkg_version} \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DBUILD_SHARED=ON \
    -DBUILD_STATIC=OFF \
    -DBUILD_TESTING=OFF \
    -DCMAKE_INSTALL_LIBDIR=lib
    
  make  
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -Dm644 ../cryptopp-CRYPTOPP_${_pkg_version}/License.txt ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
  install -Dm644 ${CACHE_PATH}/libcrypto++.pc ${pkg_prefix}/usr/lib/pkgconfig/libcrypto++.pc
}
