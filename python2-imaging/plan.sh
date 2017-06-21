pkg_origin=cosmos

pkg_name=python2-imaging
_pkg_name=Imaging
pkg_version=1.1.7
pkg_description="PIL. Provides image processing capabilities for python"
pkg_upstream_url="http://www.pythonware.com/products/pil/index.htm"
pkg_license=('custom:"pil"')
pkg_deps=('python2' 'libjpeg' 'freetype2') 
pkg_build_deps=('tk')
optpkg_deps=('tk')
pkg_source=("http://effbot.org/downloads/${_pkg_name}-$pkg_version.tar.gz")
pkg_shasum=('fc14a54e1ce02a0225be8854bfba478e')

do_build() {
  export CFLAGS="$CFLAGS -fno-strict-aliasing"
  
  python2 setup.py build_ext
}

do_package() {
  python2 setup.py install --root=$CACHE_PATH
  
  install -dm755 $CACHE_PATH/usr/include/python2.7/
  install -m644 -t $CACHE_PATH/usr/include/python2.7/ libImaging/*.h 

  # do not have files ending in .py in /usr/bin
  for f in pildriver pilprint pilconvert pilfile pilfont; do
    mv $CACHE_PATH/usr/bin/$f{.py,}
  done

  install -Dm644 $CACHE_PATH/${_pkg_name}-$pkg_version/README $CACHE_PATH/usr/share/licenses/$pkg_name/README
}
