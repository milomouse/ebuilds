# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $ mifo-9999

EAPI=5

inherit git-2

DESCRIPTION="MPlayer daemon with preset/native commands controlled through a FIFO"
HOMEPAGE="https://github.com/milomouse/mifo"
SRC_URI=""
EGIT_REPO_URI="git://github.com/milomouse/mifo.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="sys-apps/coreutils
	>=app-shells/zsh-5.0.2
	|| ( media-video/mplayer2[unicode(+)] media-video/mplayer[unicode(+)] )"
DEPEND="${RDEPEND}"

src_install() {
	exeinto /usr/bin
	doexe ${PN}
	dodoc LICENSE
}
