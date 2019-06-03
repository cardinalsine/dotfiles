#!/bin/sh
./configure --with-features=huge \
	--enable-multibyte \
	--enable-pythoninterp=yes \
	--with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
	--enable-python3interp=yes \
	--with-python3-config-dir=/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu \
	--enable-gui=gtk2 \
	--enable-cscope \
	--prefix=/usr/local