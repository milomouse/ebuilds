# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $ sxiv-9999

EAPI=5

inherit eutils savedconfig git-2 toolchain-funcs

DESCRIPTION="Simple (or small or suckless) X Image Viewer"
HOMEPAGE="https://github.com/muennich/sxiv/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/muennich/sxiv.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="media-libs/giflib
	media-libs/imlib2[X]
	media-libs/libexif
	x11-libs/libX11"
DEPEND="${RDEPEND}"

src_prepare() {
	tc-export CC

	restore_config config.h
}

src_compile() {
	emake PREFIX=/usr
}

src_install() {
	emake DESTDIR="${ED}" PREFIX=/usr install
	dodoc README.md

	save_config config.h
}
