pkg_origin=

pkg_name=virtualbox-ext-oracle
pkg_version=5.1.22
_build=115126
pkg_upstream_url='http://virtualbox.org/'
pkg_description="Oracle VM VirtualBox Extension Pack"
pkg_license=('custom:PUEL')
pkg_deps=('virtualbox-qt5')
install=${pkg_name}.install
pkg_source=("http://download.virtualbox.org/virtualbox/${pkg_version}/Oracle_VM_VirtualBox_Extension_Pack-${pkg_version}-${_build}.vbox-extpack")
pkg_shasum=('78b01ef9443f0bb1e31489ee7855135a')

do_package() {
  cd ${CACHE_PATH}
  
  install -D -m 644 Oracle_VM_VirtualBox_Extension_Pack-${pkg_version}-${_build}.vbox-extpack \
    ${pkg_prefix}/usr/share/virtualbox/extensions/Oracle_VM_VirtualBox_Extension_Pack-${pkg_version}.vbox-extpack
    
  install -D -m 644 ExtPack-license.txt ${pkg_prefix}/usr/share/licenses/${pkg_name}/PUEL
}

