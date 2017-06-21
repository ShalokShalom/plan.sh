pkg_origin=

pkg_name=filter_audio
pkg_version=0.0.1
_commit=ada2f4fdc04940cdeee47caffe43add4fa017096
pkg_description="Lightweight audio filtering library made from webrtc code."
pkg_upstream_url="https://github.com/irungentoo/filter_audio"
pkg_license=('GitHub Terms of Service')
pkg_deps=('glibc')
pkg_source=("https://github.com/irungentoo/filter_audio/archive/${_commit}.zip"
        'github-terms-of-service')
pkg_shasum=('7b9405ddd09a6c0a90a986a6aecba4c8'
         '01610a1f5e1cd6227c38c8b01dc65307')

do_build() {
    cd ${pkg_name}-${_commit}
    
    make
}

do_package() {
    cd ${pkg_name}-${_commit}
    make DESTDIR=$pkg_prefix PREFIX=/usr install
    
    install -Dm644 ${CACHE_PATH}/github-terms-of-service ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
