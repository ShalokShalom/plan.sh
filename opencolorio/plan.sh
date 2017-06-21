pkg_origin=

pkg_name=opencolorio
pkg_version=1.0.9
pkg_description="A color management framework for visual effects and animation"
pkg_upstream_url="http://opencolorio.org"
pkg_license=('BSD')
pkg_deps=('python3')
pkg_build_deps=('cmake')
pkg_source=("https://github.com/imageworks/OpenColorIO/tarball/v${pkg_version}")
pkg_shasum=('ad3c4ea59c010a18d79276ab9d83af95')

do_build() 
{
  mv imageworks-OpenColorIO-* ${pkg_name}-${pkg_version}
  cd ${pkg_name}-${pkg_version}
   
  cmake -DCMAKE_INSTALL_PREFIX=/usr .
  make 
}

do_package() 
{
  cd ${pkg_name}-${pkg_version}

  make DESTDIR=${pkg_prefix} install 

  install -Dm644 LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}

