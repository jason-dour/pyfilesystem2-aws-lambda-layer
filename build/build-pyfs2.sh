#!/bin/bash
#
# build-pyfs2.sh - Build the PyFilesystem2 lambda layer.

pip install fs --prefix python
pip install fs-s3fs --prefix python

zipfile=`echo $AWS_EXECUTION_ENV | sed "s#.*_#pyfilesystem2-#"`
python <<HEREND
import shutil

shutil.make_archive('$zipfile','zip','.','python')
HEREND

rm -rf python

exit