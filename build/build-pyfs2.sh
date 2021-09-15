#!/bin/bash
#
# build-pyfs2.sh - Build the PyFilesystem2 lambda layer.

pip install fs --prefix python
pip install fs-s3fs --prefix python

version=`awk -F= '/VERSION/{print substr($2,0,3)}' /var/runtime/runtime-release`
zipfile="pyfilesystem2-python${version}"
python <<HEREND
import shutil

shutil.make_archive('$zipfile','zip','.','python')
HEREND

rm -rf python

exit