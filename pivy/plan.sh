pkg_origin=cosmos

pkg_name=pivy
pkg_version=20101206
_commit=8eab90908f2a
pkg_description="Coin binding for Python"
pkg_upstream_url="http://pivy.coin3d.org"
pkg_license=('custom')
pkg_deps=('python2' 'soqt')
pkg_build_deps=('swig')
pkg_source=('https://bitbucket.org/Coin3D/pivy/get/tip.tar.bz2')
pkg_shasum=('a86af2071ec4d8dee61a138167508188')

do_package() {
    python2 setup.py install --root=${pkg_prefix}
    
    install -D -m 644 LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}


