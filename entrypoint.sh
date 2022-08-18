#!/bin/bash

for dockerfile in $* ; do
    /bin/dockpin docker check -f $dockerfile >> out.dockpin 2>&1
done

if grep 'is not at its latest' out.dockpin >/dev/null ; then
    echo The following images are not pinned to their latest hashes:
    image=`grep 'is not at its' out.dockpin|cut -d' ' -f1`
    echo $image
    echo "::set-output name=not_latest::true"
else
    echo All base image references are up to date
    echo "::set-output name=not_latest::false"
fi

