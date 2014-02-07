# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $ mosml-9999

EAPI=5

inherit eutils git-2

DESCRIPTION="Moscow ML - a lightweight implementation of Standard ML (SML)"
HOMEPAGE="http://mosml.org"
SRC_URI=""
EGIT_REPO_URI="git://github.com/kfl/mosml.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="strip"

DEPEND=""
RDEPEND=""

src_prepare() {

	sed -i -e 's/$(LD)/$(LD) $(LDFLAGS)/g' src/runtime/Makefile || die "Sed failed"
	sed -i -e "s|^CPP=/lib/cpp|CPP=${EPREFIX}/usr/bin/cpp|" src/Makefile.inc \
		|| die "Sed failed"
	# disable jobserver
	unset MAKEFLAGS

}

src_compile() {

	cd src
	emake CC=$(tc-getCC) CPP="$(tc-getCPP) -P -traditional -Dunix -Umsdos" \
		PREFIX="${EPREFIX}"/usr world || die

}

src_install() {

	cd src
	emake PREFIX="${ED}"/usr install || die
	dodoc  ../README || die

}
