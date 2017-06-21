pkg_origin=

pkg_name=keneric
pkg_version=0.3
pkg_description="Generic thumbnailer for when there is no dedicated KDE thumbnailer."
pkg_upstream_url="https://www.linux-apps.com/content/show.php/Keneric+KDE+(KF5)+thumbnailer?content=174485"
pkg_license=('GPL')
pkg_deps=('kio')
pkg_build_deps=('extra-cmake-modules')
pkg_source=("https://dl.opendesktop.org/api/files/download/id/1460971625/174485-${pkg_name}-${pkg_version}.tar.gz"
        'kenericblend.desktop'
        'kenerickrita.desktop'
        'kenericopend.desktop'
        'kenericwmf.desktop'
        'stripPicture')
pkg_shasum=('29cc6c23fef1c766c409b35d51628dce'
         '723f0d5769a5e35019ba5892ce72f265'
         '52eb5908aa2414c490853312b6f71a81'
         '3db421742b4a0dbad6cd60faf10b6f5d'
         '8299bd12069baeb8286eb0e03aab08ad'
         '519391fc8c369f6236d8a7cc39f9a98f')

do_build() {
  mkdir -p build
  cd build

  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build
  make DESTDIR=${pkg_prefix} install
  
  mkdir -p ${pkg_prefix}/usr/share/kservices5
  install -Dm644 ${CACHE_PATH}/*.desktop ${pkg_prefix}/usr/share/kservices5
  
  mkdir -p ${pkg_prefix}/usr/bin
  install -Dm755 ${CACHE_PATH}/stripPicture ${pkg_prefix}/usr/bin
}
