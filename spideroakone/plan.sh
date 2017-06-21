pkg_origin=

pkg_name=spideroakone
_pkg_name=SpiderOakONE
pkg_version=6.3.0
pkg_description="Secure and consolidated free online backup, storage, access, sharing & sync tool for Windows, Mac OS X, and Linux."
pkg_upstream_url="https://spideroak.com/"
pkg_deps=('krb5' 'python2' 'libpng12')
pkg_build_deps=('desktop-file-utils')
pkg_license=('custom')
install=spideroak.install
pkg_source=("${_pkg_name}-${pkg_version}-amd64.deb"::"https://spideroak.com/getbuild?platform=ubuntu&arch=x86_64&beta=no"
        "terms.txt")
pkg_shasum=('6b7c00c75fa35e3892c7d0b749cd6fbb'
         'c565cf80e4c4a44cc3e99c8f67813753')

do_package() {
    tar -zxvf ${CACHE_PATH}/data.tar.gz -C ${pkg_prefix}/
    
    rm -r ${pkg_prefix}/etc/apt
    # use system libs
    rm -r ${pkg_prefix}//opt/SpiderOakONE/lib/libstdc++.so.6
    rm -r ${pkg_prefix}//opt/SpiderOakONE/lib/libgcc_s.so.1
    rm -r ${pkg_prefix}//opt/SpiderOakONE/lib/libpng12.so.0
    rm -r ${pkg_prefix}//opt/SpiderOakONE/lib/libz.so.1
    
    install -Dm644 terms.txt ${pkg_prefix}/usr/share/licenses/${pkg_name}/terms.txt
}
