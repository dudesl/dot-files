set nocompatible
syntax on
filetype on
filetype plugin on
filetype indent on

set history=1000
set showmatch
set matchtime=0
set shortmess=atI
set ruler
set number
set showcmd

set sidescroll=1
set sidescrolloff=3

" Set xterm title
set title

" Search options
set hlsearch
set incsearch
set ignorecase
set smartcase

set noerrorbells
set printoptions=paper:letter

" Keep more lines of context
set scrolloff=3

" Make backspace delete lots of things
set backspace=indent,eol,start

" Auto-backup files and .swp files don't go to pwd
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Allow switching edited buffers without saving
set hidden

" Look for the file in the current directory, then south until you reach home.
set tags=tags;~/

" Who needs .gvimrc?
"if has('gui_running')
"  set encoding=utf-8
"  "set guifont=Monospace\ Bold\ 9
"  set guifont=Bitstream\ Vera\ Sans\ Mono\ 9
"  " Turn off toolbar and menu
"  set guioptions-=T
"  set guioptions-=m
"  colorscheme inkpot
"else
colorscheme desert
"end

" Change <Leader>
let mapleader = ","

" Quick timeouts on key combinations.
set timeoutlen=300

" Alternatives to ESC:
"imap jkl <ESC>
"imap jlk <ESC>
"imap kjl <ESC>
"imap klj <ESC>
"imap lkj <ESC>
"imap ljk <ESC>
"imap ;l <ESC>

" "Very magic" regexes in searches
"nnoremap / /\v
"nnoremap ? ?\v

" Vi-style editing in the command-line
"nnoremap : q:a
"nnoremap / q/a
"nnoremap ? q?a

" Lusty
"let g:LustyJugglerShowKeys = 2
let g:LustyExplorerSuppressRubyWarning = 1
"let g:LustyExplorerAlwaysShowDotFiles = 1
nmap <silent> <Leader>f :LustyFilesystemExplorer<CR>
nmap <silent> <Leader>b :LustyBufferExplorer<CR>
nmap <silent> <Leader>r :LustyFilesystemExplorerFromHere<CR>
nmap <silent> <Leader>g :LustyBufferGrep<CR>
nmap <silent> <Leader>j :LustyJuggler<CR>
" nmap <silent> <TAB> :LustyJugglePrevious<CR>

"let g:LustyJugglerAltTabMode=1
"noremap <silent> <A-s> :LustyJuggler<CR>

" Window management
"nmap <silent> <Leader>xo :wincmd j<CR>

" Catch trailing whitespace
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>s :set nolist!<CR>

" Fix command typos (stolen from Adam Katz)
nmap ; :

" ` is more useful than ' but less accessible.
nnoremap ' `
nnoremap ` '

" Buffer management
nmap <C-h> :tabp<CR>
nmap <C-l> :tabn<CR>
nmap <C-k> :bp<CR>
nmap <C-j> :bn<CR>
map <s-t> :tabe %<cr>
"nmap <TAB> :b#<CR>
"nmap <C-q> :bd<CR>
vmap <C-d> :bw<CR>
nmap <C-d> :bw<CR>

" Toggle highlighting
" nmap <silent> <C-n> :silent :set nohls!<CR>:silent :set nohls?<CR>
nmap <silent> <C-n> :silent :nohlsearch<CR>

" Scroll faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
vnoremap <C-e> 3<C-e>
vnoremap <C-y> 3<C-y>

" % matches on if/else, html tags, etc.
runtime macros/matchit.vim

" Bash-like filename completion
set wildmenu
set wildmode=list:longest
set wildignore=*.o,*.fasl

autocmd BufRead *.xfa set filetype=xml
autocmd BufRead *.xru set filetype=xml
autocmd BufRead *.xna set filetype=xml
autocmd BufRead *.qcf set filetype=lisp
autocmd BufRead qpx.inc set filetype=make
autocmd BufRead letter* set filetype=mail
autocmd Filetype mail set fo -=l autoindent spell

" ITA indenting style
autocmd Filetype c,cpp,h set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
" JSH indenting style
"autocmd Filetype c,cpp,h set tabstop=8 softtabstop=4 shiftwidth=4 noexpandtab
" Wimba indenting style, sort-of
"autocmd Filetype c,cpp,h set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
" Viewglob
"autocmd Filetype c,cpp,h,sh set cindent autoindent

autocmd Filetype sh set ts=4 shiftwidth=2 expandtab
autocmd Filetype lisp,ruby,xml,html set ts=8 shiftwidth=2 expandtab
autocmd Filetype python set ts=4 shiftwidth=4 expandtab
autocmd Filetype xml,xslt,diff,ruby color desert
autocmd Filetype xml,xslt,diff,ruby set expandtab
autocmd BufReadPre viper,.viper set filetype=lisp

autocmd BufRead ~/stellar/* set lbr formatoptions=l

" a.vim
nmap <silent> <Leader>h :A<CR>

" Indent XML readably
function! DoPrettyXML()
	1,$!xmllint --format --recover -
endfunction
command! PrettyXML call DoPrettyXML()

" old settings
set autoindent
set smartindent

" eclim configs
filetype plugin on
nnoremap <silent> <buffer> <leader>i :JavaImport<cr>
nnoremap <silent> <buffer> <leader>e :JavaCorrect<cr>
nnoremap <silent> <buffer> <leader>w :w<CR>


" EFind file in current directory and edit it.
function! EFind(name)
	let l:list=system("find . -name '".a:name.".*' | grep -v '\.class' | grep -v '/target/' | sort | perl -ne 'print \"$.\\t$_\"'")
	let l:num=strlen(substitute(l:list, "[^\n]", "", "g"))
	if l:num < 1
		echo "'".a:name."' not found"
		return
	endif
	if l:num != 1
		echo l:list
		let l:input=input("Which ? (CR=nothing)\n")
		if strlen(l:input)==0
			return
		endif
		if strlen(substitute(l:input, "[0-9]", "", "g"))>0
			echo "Not a number"
			return
		endif
		if l:input<1 || l:input>l:num
			echo "Out of range"
			return
		endif
		let l:line=matchstr("\n".l:list, "\n".l:input."\t[^\n]*")
	else
		let l:line=l:list
	endif
	let l:line=substitute(l:line, "^[^\t]*\t./", "", "")
	execute ":tabe ".l:line
endfunction
command! -nargs=1 EFind :call EFind("<args>")

" Find file in current directory and edit it.
function! Find(name)
	"let l:list=system("find . -name '".a:name."*' | grep -v '\.class' | grep -v '/target/' | sort | perl -ne 'print \"$.\\t$_\"'")
	let l:list=system("find . -name '".substitute(a:name,"","*","g")."' | grep -v '\.class' | grep -v '/target/' | sort | perl -ne 'print \"$.\\t$_\"'")
	let l:num=strlen(substitute(l:list, "[^\n]", "", "g"))
	if l:num < 1
		echo "'".a:name."' not found"
		return
	endif
	if l:num != 1
		echo l:list
		let l:input=input("Which ? (CR=nothing)\n")
		if strlen(l:input)==0
			return
		endif
		if strlen(substitute(l:input, "[0-9]", "", "g"))>0
			echo "Not a number"
			return
		endif
		if l:input<1 || l:input>l:num
			echo "Out of range"
			return
		endif
		let l:line=matchstr("\n".l:list, "\n".l:input."\t[^\n]*")
	else
		let l:line=l:list
	endif
	let l:line=substitute(l:line, "^[^\t]*\t./", "", "")
	execute ":tabe ".l:line
endfunction
command! -nargs=1 Find :call Find("<args>")

" Find file in current directory and edit it.
function! RFind(name)
	"let l:list=system("grep -slr '".a:name."'  test grails-app scripts *.groovy src web-app *.yaml *.c *.h | grep -v '\.class' | grep -v '\.swp' | perl -ne 'print \"$.\\t$_\"'")

	"let l:list=system("grep -slr '".a:name."'  $(find data2 -name \"*.xml\") | perl -ne 'print \"$.\\t$_\"'")
	"let l:num=strlen(substitute(l:list, "[^\n]", "", "g"))

	"if l:num < 1
          let l:list=system("grep -slr '".a:name."'  $(find . -name \"*.groovy\" -o -name \"*.java\" -o -name \"*.html\" -o -name \"*.gsp\" -o -name \"*.sql\" -o -name \"*.xml\" -o -name \"*.yaml\" | grep -v \"/target/\") | perl -ne 'print \"$.\\t$_\"'")
        "endif

	let l:num=strlen(substitute(l:list, "[^\n]", "", "g"))
	if l:num < 1
		echo "'".a:name."' not found"
		return
	endif
	if l:num != 1
		echo l:list
		let l:input=input("Which ? (CR=nothing) matches for '".a:name."'\n")
		if strlen(l:input)==0
			return
		endif
		if strlen(substitute(l:input, "[0-9]", "", "g"))>0
			echo "Not a number"
			return
		endif
		if l:input<1 || l:input>l:num
			echo "Out of range"
			return
		endif
		let l:line=matchstr("\n".l:list, "\n".l:input."\t[^\n]*")
	else
		let l:line="_".l:list
	endif
	let l:line=substitute(l:line, "^[^\t]*\t./", "", "")
	let l:line=substitute(l:line, ".*\t", "", "")
	echo "por abrir ".l:line
	execute ":tabe ".l:line
endfunction
command! -nargs=1 RFind :call RFind("<args>")

" Alias for saving
function! W(name)
	execute ":w"
endfunction
command! -nargs=0 W :call W("<args>")

" ident for groovy
function! GIdent()
	execute ':%s/{\s*\n/{\r/g'
	execute ':%s/\[\s*\n/[\r/g'
	execute ':%s/->\s*\n/->\r/g'
	execute ':g/.*/normal ggvG1000<'
	execute ':g/{\s*\n/normal j0>i{'
	execute ':g/->\s*\n/normal j0>i{<<'
	execute ':g/\[\s*\n/normal j0>i['
	execute ':g/(\s*\n/normal j0>i('
endfunction
command! -nargs=0 GIdent :call GIdent()

cmap w!! %!sudo tee > /dev/null %


" Execute actions on the current file based on the file name (F5)
function! ExecuteFile()
  let file = expand("%")

  if stridx(file, "/tmp/sample.rb") != -1
    " call PreviewResults("ruby -rubygems " . file)
    call ExecuteTest()
  elseif stridx(file, ".mo") != -1
    call PreviewResults("mo " . file)
  elseif stridx(file, ".io") != -1
    call PreviewResults("osxvm " . file)
  elseif stridx(file, ".ml") != -1
    call PreviewResults("ocaml " . file)
  elseif stridx(file, "_test.rb") != -1
    call ExecuteTest()
  elseif stridx(file, ".rb") != -1
    execute "!ruby %"
  elseif stridx(file, "Tests.groovy") != -1
    execute "!grails test-app"
  elseif stridx(file, "Story.groovy") != -1
    execute "!grails test-app -functional"
  elseif stridx(file, ".groovy") != -1
    execute "!groovy %"
  elseif stridx(file, ".lua") != -1
    call PreviewResults("lua " . file)
  elseif stridx(file, ".min") != -1
    call PreviewResults("min " . file)
  elseif stridx(file, ".haml") != -1
    execute "!haml % " . substitute(file, "\.haml$", ".html", "")
  elseif stridx(file, ".dot") != -1
    let dotfile = substitute(file, "\.dot$", ".pdf", "")
    execute "!dot -Tpdf % > " . dotfile . " && evince " . dotfile
  elseif stridx(file, ".markdown") != -1
    execute "!maruku %"
  elseif stridx(file, ".md") != -1
    execute "!maruku %"
  elseif stridx(file, ".sass") != -1
    execute "!sass % " . substitute(file, "\.sass$", ".css", "")
  elseif stridx(file, ".html") != -1
    execute "!google-chrome $PWD/%"
  elseif stridx(file, ".s") != -1
    call PreviewResults("shiny " . file)
  endif
endfunction

map <F5> :call ExecuteFile()<CR>
imap <F5> <ESC>:w!<CR>:call ExecuteFile()<CR>

" find files with the string in word or selected string
nmap <F3> *"zyiw:exe "RF ".@z.""<CR>
vmap <F3> "zy:exe "RF ".@z.""<CR>

" find files with name matching the word
nmap <F4> "zyiw:exe "EF ".@z.""<CR>

" sobre un log abre archivo en la linea indicada
nmap <F2> "zyiwf:l"xyw:exe "F ".@z.""<CR>:exe "".@x.""<CR>
nmap <Space> :


"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

" macro for bookmarkletizise a js
let @b='ggOjavascript:(function(){G}Go})()ggvG1000<:%s/ /%20/g:%s/\n//g'

" switch between tabs or windows in vs
nmap <tab> <c-w>l
nmap <s-tab> <c-w>h

" to select an entire function definition
map t f{vaBV

" to extract method refactoring
function! ExtractMethod() range
  let name = inputdialog("Name of new method:")
  '<
  exe "normal! O\<BS>def " . name ."()\{\<Esc>"
  '>
  exe "normal! oreturn ;\<CR>}\<Esc>k"
  s/return/\/\/ return/ge
  normal! j%
  normal! kf(
  exe "normal! yyPi// = \<Esc>wdwA;\<Esc>"
  normal! ==
  normal! j0w
endfunction
vmap em :call ExtractMethod()<CR>

" tabs like chrome
nmap <leader>t :tabe<cr>
nmap <c-PageUp> :tabp<cr>
nmap <c-PageDown> :tabn<cr>

" to copy paste println chains: for example: println \"callerId && siteId \"
" to callerId: ${callerId} && siteId: ${callerId} "
" note: it goes to a blank
let @h='yf Pi=${kDf i}'

" always source .vimrc when saving
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

" open ~/.vimrc with ,v
nmap <leader>v :tabedit $MYVIMRC<CR>

" open browser with Vex . and open files in other tab with t
" source: http://vimcasts.org/episodes/the-file-explorer/#comment-45366660
let g:netrw_browse_split=4 " Open file in previous buffer


" colorscheme for linenumbers
hi LineNr ctermfg=lightgrey ctermbg=darkgray



