pkg_origin=cosmos

pkg_name=yaml-cpp
pkg_version=0.5.3
pkg_description="YAML parser and emitter in C++ matching the YAML 1.2 spec"
pkg_upstream_url="https://github.com/jbeder/yaml-cpp"
pkg_license=('MIT')
pkg_deps=('boost')
pkg_build_deps=('cmake')
pkg_source=("https://github.com/jbeder/yaml-cpp/archive/release-${pkg_version}.tar.gz")
pkg_shasum=('64200ca0bf5e0af065804d8d3e8f6d42')

do_build() {

    cmake . -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_SHARED_LIBS=ON
    make
}

do_package() {
    make DESTDIR=${CACHE_PATH} install

    install -Dm644 LICENSE ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
    
    install -Dm644 yaml-cpp-config.cmake ${CACHE_PATH}/usr/lib/cmake/${pkg_name}/yaml-cpp-config.cmake
    install -Dm644 yaml-cpp-config-version.cmake ${CACHE_PATH}/usr/lib/cmake/${pkg_name}/yaml-cpp-config-version.cmake
    install -Dm644 yaml-cpp-targets.cmake ${CACHE_PATH}/usr/lib/cmake/${pkg_name}/yaml-cpp-targets.cmake
}
