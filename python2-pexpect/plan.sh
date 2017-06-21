pkg_origin=cosmos
# Maintainer: Neophytos Kolokotronis <tetris4@gmail.com>
# Contributors from Arch: Alexander Rødseth <rodseth@gmail.com>
# 			  Aaron Schaefer <aaron@elasticdog.com>

pkg_name=python2-pexpect
pkg_version=2.4
pkg_description='Make Python a better tool for controlling and automating other programs'
pkg_upstream_url='http://pexpect.sourceforge.net/'
pkg_license=('MIT')
pkg_deps=('python2')
pkg_source=("http://pypi.python.org/packages/source/p/pexpect/pexpect-$pkg_version.tar.gz")
sha256sums=('43c788f59dcf4bed677fd0b16891787dbf747e210ffedb6e90156fbbbd4d3b7b')

do_package() {
  sed -i 's:#!/usr/bin/env python:#!/usr/bin/python2:' FSM.py
  python2 setup.py install --root=$CACHE_PATH
  install -Dm644 LICENSE $CACHE_PATH/usr/share/licenses/$pkg_name/LICENSE
}
