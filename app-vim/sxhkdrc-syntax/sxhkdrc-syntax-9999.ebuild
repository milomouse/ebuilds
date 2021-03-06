# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $ sxhkdrc-syntax-9999

EAPI=5

inherit vim-plugin git-2

EGIT_REPO_URI="git://github.com/baskerville/vim-sxhkdrc.git"

DESCRIPTION="vim plugin: sxhkd syntax highlighting for the configuration file sxhkdrc"
HOMEPAGE="https://github.com/baskerville/vim-sxhkdrc"
LICENSE="vim"
IUSE=""

VIM_PLUGIN_HELPFILES="sxhkdrc-syntax"
VIM_PLUGIN_MESSAGES="filetype"

pkg_postinst() {
	vim-plugin_pkg_postinst
}
