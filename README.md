Based on eclim and http://items.sjbach.com/319/configuring-vim-right and another for Find files and gRepFind files

### Added:

	- *F3* in normal or visual mode take the word/selection and searchit by content files within the current directory matching the word/selection
	- Snipmate
	http://www.vim.org/scripts/script.php?script_id=2540
	- *:GI* or *:GIdent* to ident groovy
	- *F4* adove a string it searches for a file with that name
	- *F2* in a log string like FileService.groovy: 22 it jumps to that file in that line
	- *:Vex .* to open file browser, with enter it opens in same tab, with t it opens in new tab
	- *ctrl + j|k* to move between buffers in the same tab
	- *ctrl + h|l* to move between tabs
	- *ctrl + d* to close the tab
	- *,t* to open current tab in other tab
	- *,v* to edit ~/.vimrc, autoapply when saving that file


### Installing:

	ln -s ~/dev/dot-files/gitconfig .gitconfig
	ln -s ~/dev/dot-files/vim .vim
	ln -s ~/dev/dot-files/vimrc .vimrc
	ln -s ~/dev/dot-files/bashrc .bashrc

### Checking:

	ls -lh .vim .vimrc .bashrc .gitconfig
