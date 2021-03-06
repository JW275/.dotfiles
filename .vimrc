set t_Co=256
set nu
set autoindent
set cindent
set smartindent
set nobackup
set ruler
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set ignorecase
set hlsearch
set incsearch
set showmode
set history=1000
set fileencodings=utf-8,euc-kr
set background=dark
set bs=2
set nocp
set cino+=g0

syntax on
filetype on

vnoremap <TAB> >gv
vnoremap <s-tab> <gv
nnoremap <esc>t   :tabnew<cr>
nnoremap <esc>1   1gt
nnoremap <esc>2   2gt
nnoremap <esc>3   3gt
nnoremap <esc>4   4gt
nnoremap <esc>5   5gt
nnoremap <esc>6   6gt
nnoremap <esc>7   7gt
nnoremap <esc>8   8gt
nnoremap <esc>9   9gt

nnoremap <CR> o<ESC>
nno6remap <Backspace> X

if has("gui_running")
	set background=dark
endif
hi clear
if exists("syntax_on")
	syntax reset
endif

"""let colors_name = "vividchalk"

" First two functions adapted from inkpot.vim

" map a urxvt cube number to an xterm-256 cube number
fun! s:M(a)
	return strpart("0245", a:a, 1) + 0
endfun

" map a urxvt colour to an xterm-256 colour
fun! s:X(a)
	if &t_Co == 88
		return a:a
	else
		if a:a == 8
			return 237
		elseif a:a < 16
			return a:a
		elseif a:a > 79
			return 232 + (3 * (a:a - 80))
		else
			let l:b = a:a - 16
			let l:x = l:b % 4
			let l:y = (l:b / 4) % 4
			let l:z = (l:b / 16)
			return 16 + s:M(l:x) + (6 * s:M(l:y)) + (36 * s:M(l:z))
		endif
	endif
endfun

function! E2T(a)
	return s:X(a:a)
endfunction

function! s:choose(mediocre,good)
	if &t_Co != 88 && &t_Co != 256
		return a:mediocre
	else
		return s:X(a:good)
	endif
endfunction

function! s:hifg(group,guifg,first,second,...)
	if a:0 && &t_Co == 256
		let ctermfg = a:1
	else
		let ctermfg = s:choose(a:first,a:second)
	endif
	exe "highlight ".a:group." guifg=".a:guifg." ctermfg=".ctermfg
endfunction

function! s:hibg(group,guibg,first,second)
	let ctermbg = s:choose(a:first,a:second)
	exe "highlight ".a:group." guibg=".a:guibg." ctermbg=".ctermbg
endfunction

hi link railsMethod         PreProc
hi link rubyDefine          Keyword
hi link rubySymbol          Constant
hi link rubyAccess          rubyMethod
hi link rubyAttribute       rubyMethod
hi link rubyEval            rubyMethod
hi link rubyException       rubyMethod
hi link rubyInclude         rubyMethod
hi link rubyStringDelimiter rubyString
hi link rubyRegexp          Regexp
hi link rubyRegexpDelimiter rubyRegexp
hi link javascriptRegexpString  Regexp
hi link javascriptNumber        Number
hi link javascriptNull          Constant
highlight link diffAdded        String
highlight link diffRemoved      Statement
highlight link diffLine         PreProc
highlight link diffSubname      Comment

call s:hifg("Normal","#EEEEEE","White",87)
if &background == "light" || has("gui_running")
	hi Normal guibg=Black ctermbg=Black
else
	hi Normal guibg=Black ctermbg=NONE
endif
highlight StatusLine    guifg=Black   guibg=#aabbee gui=bold ctermfg=Black ctermbg=White  cterm=bold
highlight StatusLineNC  guifg=#444444 guibg=#aaaaaa gui=none ctermfg=Black ctermbg=Grey   cterm=none
highlight Ignore        ctermfg=Black
highlight WildMenu      guifg=Black   guibg=#ffff00 gui=bold ctermfg=Black ctermbg=Yellow cterm=bold
highlight Cursor        guifg=Black guibg=White ctermfg=Black ctermbg=White
call s:hibg("ColorColumn","#333333","DarkGrey",81)
call s:hibg("CursorLine","#333333","DarkGrey",81)
call s:hibg("CursorColumn","#333333","DarkGrey",81)
highlight NonText       guifg=#404040 ctermfg=8
highlight SpecialKey    guifg=#404040 ctermfg=8
highlight Directory     none
high link Directory     Identifier
highlight ErrorMsg      guibg=Red ctermbg=DarkRed guifg=NONE ctermfg=NONE
highlight Search        guifg=NONE ctermfg=NONE gui=none cterm=none
call s:hibg("Search"    ,"#555555","DarkBlue",81)
highlight IncSearch     guifg=White guibg=Black ctermfg=White ctermbg=Black
highlight MoreMsg       guifg=#00AA00 ctermfg=Green
highlight LineNr        guifg=#DDEEFF ctermfg=White
call s:hibg("LineNr"    ,"#222222","DarkBlue",80)
highlight Question      none
high link Question      MoreMsg
highlight Title         guifg=Magenta ctermfg=Magenta
highlight VisualNOS     gui=none cterm=none
call s:hibg("Visual"    ,"#555577","LightBlue",83)
call s:hibg("VisualNOS" ,"#444444","DarkBlue",81)
call s:hibg("MatchParen","#1100AA","DarkBlue",18)
highlight WarningMsg    guifg=Red ctermfg=Red
highlight Error         ctermbg=DarkRed
highlight SpellBad      ctermbg=DarkRed
highlight SpellRare     ctermbg=DarkMagenta
highlight SpellCap      ctermbg=DarkBlue
highlight SpellLocal    ctermbg=DarkCyan

call s:hibg("Folded"    ,"#110077","DarkBlue",17)
call s:hifg("Folded"    ,"#aaddee","LightCyan",63)
highlight FoldColumn    none
high link FoldColumn    Folded
highlight DiffAdd       ctermbg=4 guibg=DarkBlue
highlight DiffChange    ctermbg=5 guibg=DarkMagenta
highlight DiffDelete    ctermfg=12 ctermbg=6 gui=bold guifg=Blue guibg=DarkCyan
highlight DiffText      ctermbg=DarkRed
highlight DiffText      cterm=bold ctermbg=9 gui=bold guibg=Red

highlight Pmenu         guifg=White ctermfg=White gui=bold cterm=bold
highlight PmenuSel      guifg=White ctermfg=White gui=bold cterm=bold
call s:hibg("Pmenu"     ,"#000099","Blue",18)
call s:hibg("PmenuSel"  ,"#5555ff","DarkCyan",39)
highlight PmenuSbar     guibg=Grey ctermbg=Grey
highlight PmenuThumb    guibg=White ctermbg=White
highlight TabLine       gui=underline cterm=underline
call s:hifg("TabLine"   ,"#bbbbbb","LightGrey",85)
call s:hibg("TabLine"   ,"#333333","DarkGrey",80)
highlight TabLineSel    guifg=White guibg=Black ctermfg=White ctermbg=Black
highlight TabLineFill   gui=underline cterm=underline
call s:hifg("TabLineFill","#bbbbbb","LightGrey",85)
call s:hibg("TabLineFill","#808080","Grey",83)

hi Type gui=none
hi Statement gui=none
if !has("gui_mac")
	" Mac GUI degrades italics to ugly underlining.
	hi Comment gui=italic
	hi railsUserClass  gui=italic
	hi railsUserMethod gui=italic
endif
hi Identifier cterm=none
" Commented numbers at the end are *old* 256 color values
"highlight PreProc       guifg=#EDF8F9
call s:hifg("Comment"        ,"#9933CC","DarkMagenta",34) " 92
" 26 instead?
call s:hifg("Constant"       ,"#339999","DarkCyan",21) " 30
call s:hifg("rubyNumber"     ,"#CCFF33","Yellow",60) " 190
call s:hifg("String"         ,"#66FF00","LightGreen",44,82) " 82
call s:hifg("Identifier"     ,"#FFCC00","Yellow",72) " 220
call s:hifg("Statement"      ,"#FF6600","Brown",68) " 202
call s:hifg("PreProc"        ,"#AAFFFF","LightCyan",47) " 213
call s:hifg("railsUserMethod","#AACCFF","LightCyan",27)
call s:hifg("Type"           ,"#AAAA77","Grey",57) " 101
call s:hifg("railsUserClass" ,"#AAAAAA","Grey",7) " 101
call s:hifg("Special"        ,"#33AA00","DarkGreen",24) " 7
call s:hifg("Regexp"         ,"#44B4CC","DarkCyan",21) " 74
call s:hifg("rubyMethod"     ,"#DDE93D","Yellow",77) " 191
"highlight railsMethod   guifg=#EE1122 ctermfg=1

hi MatchParen cterm=bold ctermbg=red ctermfg=none
hi Type ctermfg=yellow
hi Comment ctermfg=99
hi Constant ctermfg=196 ctermbg=black
hi PreProc  ctermfg=44
hi Search ctermbg=red

nmap <F7> :NERDTree<CR>
nmap <F8> :Tlist<CR>
let Tlist_Use_Right_Window = 1
nmap <F9> :call ToggleErrors()<CR>

" Vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'taglist.vim'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'The-NERD-tree'
Plugin 'code_complete'
Plugin 'Syntastic'
Plugin 'Indent-Guides'
Plugin 'mattn/emmet-vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'wting/rust.vim'
Plugin 'SingleCompile'
Plugin 'fatih/vim-go'
Plugin 'AutoComplPop'
Plugin 'editorconfig/editorconfig-vim'
call vundle#end()
filetype plugin indent on

let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=244 guibg=red
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=240 guibg=red
autocmd VimEnter,Colorscheme * :IndentGuidesEnable

" 자동 주석 제거
autocmd FileType * setlocal formatoptions-=ro

" airline 설정
set laststatus=2
set t_Co=256
let g:airline_theme = 'badwolf'

if &diff
else
    au BufWinLeave *.* mkview
    au BufWinEnter *.* silent loadview
endif

au BufNewFile,BufRead *.glsl,*.fragmentshader,*.vertexshader setf glsl

" Syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 1
let g:syntastic_cpp_check_header = 1

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

highlight SyntasticErrorSign guifg=white guibg=red
highlight SyntasticErrorLine guibg=#2f0000

let g:syntastic_c_compiler = 'gcc'

let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++11'

let g:loaded_syntastic_cpp11_gcc_checker = 1
let g:syntastic_cpp11_compiler = executable('g++') ? 'g++' : 'clang++'
let g:syntastic_cpp_include_dirs = [ '../external/glfw-3.0.3/include/GLFW/', 'external/glfw-3.0.3/include/GLFW/', 'external/glm-0.9.4.0/', '../external/glm-0.9.4.0/', 'external/glew-1.9.0/include/' , '../external/glew-1.9.0/include/' ]

function! ToggleErrors()
	let old_last_winnr = winnr('$')
	lclose
	if old_last_winnr == winnr('$')
        " Nothing was closed, open syntastic error location panel
	    Errors
	endif
endfunction

au BufWinEnter *.cpp,*h syn keyword cppType shared_ptr unordered_map map vector deque queue list

au BufWinEnter *.cpp,*.c,*h set et
au BufWinEnter *.cpp,*.c,*h retab

let g:html_indent_inctags = "body,head,tbody"

let g:airline#extensions#syntastic#enabled = 1

nmap <F10> :SCCompileRun<cr>
let g:SingleCompile_autowrite = 0

au BufWinEnter *.bsv set filetype=bsv
