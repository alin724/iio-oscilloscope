#!/bin/bash

set -xe

install_deps() {
	export APT_PKGS="cmake \
		fftw \
		libmatio \
		libxml2 \
		pkg-config \
		libusb \
		gtk+ \
		gtkdatabox \
		jansson \
		glib \
		curl \
		openssl@1.1 \
		gettext \
		libserialport \
		python
        "

	__brew_install_if_not_exists() {
		brew ls --versions "$1" || \
		brew install "$1"
	}

	brew_install_if_not_exists() {
		while [ -n "$1" ] ; do
			__brew_install_if_not_exists "$1" || return 1
			shift
		done
	}

	brew_install_if_not_exists $APT_PKGS
}

install_adi_debs() {
	sudo installer -pkg ./download/libad9166-*.pkg -target /
	sudo installer -pkg ./download/libad9361-*.pkg -target /
	sudo installer -pkg ./download/libiio-*.pkg -target /
}

build_osc() {
	git clone -b fix-gtk-upgrade https://github.com/tfcollins/homebrew-formulae.git
	cd homebrew-formulae
	brew install --build-from-source ./iio-oscilloscope.rb

	export CFLAGS="-Wno-deprecated"

	mkdir -p build && cd build
	cmake ../
	make -j9
}

$@
