pkg_origin=cosmos

pkg_name=python3-configobj
pkg_version=5.0.6
pkg_description='Simple but powerful config file reader and writer for Python'
pkg_upstream_url='https://github.com/DiffSK/configobj'
pkg_license=('BSD')
pkg_deps=('python3' 'python3-six')
pkg_source=("https://github.com/DiffSK/configobj/archive/v$pkg_version.tar.gz")
pkg_shasum=('3ba0a72b09225a09c80b571ad60c3f54')

do_package() {
  python3 setup.py install --root="$CACHE_PATH" --optimize=1

  install -Dm644 LICENSE "$CACHE_PATH/usr/share/licenses/$pkg_name/LICENSE"
}
