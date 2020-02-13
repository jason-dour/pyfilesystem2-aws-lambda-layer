# pyfilesystem2-aws-lambda-layer

AWS Lambda Layer for Python PyFilesystem2 module.

## Purpose

Maybe it seems weird to add a Layer just to do "filesystem" work.  Sure, Lambda are small discrete units of work; surely they don't require a complex filesystem handler for Python?

Have you ever grown tired of Lambda's 512 MB /tmp space?  Ever hit that limit?  Ever wonder how you might get even just a *smidge* more room?

Did you notice that PyFilesystem2 does mem-fs?  S3-fs?

Maybe it won't work.  Maybe AWS will notice and shut it down.  But I say we try.

## Building the Layers

1. Make certain you have the `lambci/lambda` Docker images needed to build the layers.

    ``` shell
    $ docker images
    REPOSITORY                                                    TAG                 IMAGE ID            CREATED             SIZE
    lambci/lambda                                                 python3.8           36f0e1beec21        8 days ago          451MB
    lambci/lambda                                                 python3.7           abf60b9bbe88        8 days ago          930MB
    lambci/lambda                                                 python3.6           be7ca6842c9b        8 days ago          879MB
    ```

   1. If you do not have the images, just pull them with a `docker pull` command.

1. Confirm the build directory is clean.

    ``` shell
    $ ls -1 build
    build-pyfs2.sh
    ```

1. Then execute the docker `lambci/lambda:python` images to run the build script.

    ``` shell
    docker run --rm -v `pwd`/build:/var/task -it --entrypoint /bin/bash lambci/lambda:python3.6 ./build-pyfs2.sh

    docker run --rm -v `pwd`/build:/var/task -it --entrypoint /bin/bash lambci/lambda:python3.7 ./build-pyfs2.sh

    docker run --rm -v `pwd`/build:/var/task -it --entrypoint /bin/bash lambci/lambda:python3.8 ./build-pyfs2.sh
    ```

## Deploy the Layers

Once the layer zip files are created, you can deploy them to your AWS account with the following command:

``` shell
aws lambda publish-layer-version --layer-name "pyfilesystem2-python36" --description "PyFilesystem2 Module for Python 3.6 Runtime" --license-info "BSD-2-Clause" --compatible-runtimes "python3.6" --zip-file "fileb://build/pyfilesystem2-python3.6.zip"

aws lambda publish-layer-version --layer-name "pyfilesystem2-python37" --description "PyFilesystem2 Module for Python 3.7 Runtime" --license-info "BSD-2-Clause" --compatible-runtimes "python3.7" --zip-file "fileb://build/pyfilesystem2-python3.7.zip"

aws lambda publish-layer-version --layer-name "pyfilesystem2-python38" --description "PyFilesystem2 Module for Python 3.8 Runtime" --license-info "BSD-2-Clause" --compatible-runtimes "python3.8" --zip-file "fileb://build/pyfilesystem2-python3.8.zip"
```
