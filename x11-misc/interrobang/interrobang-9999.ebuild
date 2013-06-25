# $Header: $

EAPI=5

inherit flag-o-matic git-2 toolchain-funcs

DESCRIPTION="A tiny launcher menu packing a big bang (syntax)"
HOMEPAGE="http://github.com/TrilbyWhite/interrobang.git"
SRC_URI=""
EGIT_REPO_URI="git://github.com/TrilbyWhite/interrobang.git"

LICENSE="GPL3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bash-completion"

DEPEND="x11-libs/libX11
	bash-completion? ( app-shells/bash-completion )"
RDEPEND="${DEPEND}
	virtual/pkgconfig"

src_compile() {
	emake PREFIX=/usr
}

src_install() {
	emake PREFIX=/usr DESTDIR="${D}" install
}
