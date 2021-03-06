"""""
" Plugins
" :PlugInstall to install, :PlugUpdate to update all, :PlugClean to remove unused
call plug#begin('~/.config/nvim/plugged')

" simple file browser
" open file browser with -
Plug 'jeetsukumaran/vim-filebeagle'
let g:filebeagle_show_hidden = 1

" smart commenting
" comment/uncomment with gcc
Plug 'tpope/vim-commentary'

" manipulate surrounding pairs
" cs to change a surround, ys to add a new surround
Plug 'tpope/vim-surround'

" smart select a region of text
" repeat v to expand region
Plug 'terryma/vim-expand-region'

" repeat f and t easily
" use f/F/t/T to repeat last f/t action
Plug 'rhysd/clever-f.vim'

" jump to next occurrence of two consecutive characters
" s to start, s again to repeat
Plug 'justinmk/vim-sneak'
hi link SneakPluginTarget Search
hi link SneakPluginScope Search
let g:sneak#s_next = 1
let g:sneak#absolute_dir = 1

" git integration
" commands all start with :G
Plug 'tpope/vim-fugitive'

" unix file managment integration
Plug 'tpope/vim-eunuch'

" better in-buffer search defaults
Plug 'junegunn/vim-slash'

" fuzzy find lots of things
Plug 'junegunn/fzf', { 'dir': '~/.config/nvim/fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" runs a linter and reports errors on file save
Plug 'scrooloose/syntastic'
let g:syntastic_ocaml_checkers = ['merlin']    " OCaml linter is merlin
" let g:syntastic_ruby_checkers = ['rubylint']  " Ruby linter is ruby-lint
let g:syntastic_ruby_mri_exec = '~/.rbenv/shims/ruby'
let g:syntastic_elixir_checkers = ['elixir']  " Elixir default checker
let g:syntastic_enable_elixir_checker = 1     " override elixir security

" end syntax structures automatically
Plug 'tpope/vim-endwise'

" indents ocaml files, ocp-indent is installed with opam
Plug 'let-def/ocp-indent-vim', { 'for': 'ocaml' }

" elixir highlighting and indentation
Plug 'elixir-lang/vim-elixir'

call plug#end()


"""""
" Theme
colorscheme my_theme_light


"""""
" Key Remappings
" use ; for commands, ' to repeat movement
nnoremap ; :
vnoremap ; :
nnoremap ' ;
vnoremap ' ;

" use Q to execute default register, overrides ex mode.
nnoremap Q @q

" w!! save a file with sudo even if it was opened without
cnoremap  w!! w !sudo tee % > /dev/null

" 0 goes to first character and ^ goes to start of line
nnoremap 0 ^
nnoremap ^ 0

" make . work with visually selected lines
vnoremap . :norm.<CR>

" v for visual mode with region expand functionality, ctrl+v to shrink region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)


"""""
" Ctrl Bindings
" ctrl+a from insert mode call the omnicomplete menu
inoremap <C-a> <C-x><C-o>

" ctrl+[hjkl] navigate between split windows with
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" ctrl+s toggle spellcheck for comments
nnoremap <C-s> :setlocal invspell<CR>


"""""
" Leader Bindings
" Leader
let mapleader = "\<Space>"

" Local Leader (used for filetype specific bindings)
let maplocalleader = "\\"

" Leader+b list buffers
nmap <Leader>b :ls<CR>:buffer<Space>

" Leader+c close focused window
nmap <Leader>c <C-w><C-q>

" Leader+f open filebeagle

" Leader+[hl] go back/forward in buffer list
nmap <Leader>h :bprevious<CR>

" Leader+I show syntax highlighting groups for word under cursor
nmap <Leader>I :call <SID>SynStack()<CR>

" Leader+j format the current paragraph/selection, good for ragged text
nmap <Leader>j gqip
vmap <Leader>j gq

" Leader+[hl] go back/forward in buffer list
nmap <Leader>l :bnext<CR>

" Leader+[py] paste/yank from/to system clipboard
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>p "+p
vnoremap <Leader>P "+P

" Leader+r rot13 file
noremap <Leader>r ggg?G

" Leader+s search and replace
nmap <Leader>s :%s//g<Left><Left>

" Leader+v vertical split
noremap <Leader>v :vsplit<CR>

" Leader+[py] paste/yank from/to system clipboard
vnoremap  <Leader>y  "+y
nnoremap  <Leader>y  "+y

" Leader+/ clear highlight after search
nnoremap <silent> <Leader>/ :nohlsearch<cr>

" Leader+Leader switch between current and last buffer
nmap <Leader><Leader> <c-^>

" Local Leader+p, TODO: set for only ocaml
nmap <silent> <LocalLeader>a :call <SID>OCamlTypePaste()<CR>


"""""
" All the Little Things
set showcmd                  " show command in status line as it is composed.
set showmatch                " highlight matching brackets.
set showmode                 " show current mode.
set ruler                    " the line and column numbers of the cursor.
set number                   " line numbers on the left side.
set numberwidth=4            " left side number column is 4 characters wide.
set expandtab                " insert spaces when TAB is pressed.
set tabstop=2                " render TABs using this many spaces.
set shiftwidth=2             " indentation amount for < and > commands.
set noerrorbells             " no beeps.
set nomodeline               " disable modeline.
set nojoinspaces             " prevents inserting two spaces on a join (J)
set ignorecase               " make searching case insensitive...
set smartcase                " ... unless the query has capital letters.
set wrap                     " word wrap instead of map by character.
set colorcolumn=81           " highlight column 81
set list                     " highlight tabs and trailing spaces
set listchars=tab:>·,trail:· " symbols to display for tabs and trailing spaces
set scrolloff=3              " show next 3 lines while scrolling.
set sidescrolloff=5          " show next 5 columns while side-scrolling.
set autochdir                " switch to current file's parent directory.
set splitbelow               " horizontal split opens under active window
set splitright               " vertical split opens to right of active window
set shortmess+=I             " Don't show the intro
set autowrite                " auto write file when switching buffer
set clipboard=unnamedplus    " write to vim and system clipboards


"""""
" Vim Metadata
" manage meta files by keeping them all under .config/nvim/tmp/
set undofile  " keep undo history persistent
set backup    " backup all files
set swapfile  " save buffers periodically
" save backup and swap stuff in directories
set undodir=~/.config/nvim/tmp/undo//           " undo files
set backupdir=~/.config/nvim/tmp/backup//       " backups
set directory=~/.config/nvim/tmp/swap//         " swap files
set viminfo+=n~/.config/nvim/tmp/info/viminfo   " viminfo
" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
  call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
  call mkdir(expand(&directory), "p")
endif


"""""
" Filetype Settings
" text file config, text wraps at 80 characters
autocmd FileType text setlocal textwidth=80

" vim config config, reload vimrc every time buffer is saved
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" OCaml config, use correct version of merlin
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"


"""""
" Functions
" OCaml type sig paste
function! <SID>OCamlTypePaste()
  redir => res
  silent call merlin#TypeOf()
  redir END
  let res = "(* " . substitute(res, '^\n\+', '', '') . " *)"
  silent put=res
endfunc

" Vim theme building helper
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

