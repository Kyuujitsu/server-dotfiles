" This is Alek Monstovich's .vimrc file
" vim:set ts=2 sts=2 sw=2 expandtab
set nocompatible

"runtime bundle/vim-pathogen/autoload/pathogen.vim

filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
"call pathogen#infect()
" turn on syntax highlighting
syntax on
filetype plugin indent on

set modelines=0

" Don't show the intro message when starting vim
set shortmess=atI

" Make vim more useful
set nocompatible

" Use UTF-8 without BOM
set encoding=utf-8 nobomb
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf8,cp1251

" Change mapleader
let mapleader=","

" Enable mouse in all modes
set mouse=a
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic Editing Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set lazyredraw
set splitbelow
set splitright
" Don't reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don't try to highlight lines longer than 800 characters
set synmaxcol=800
" Resize splits when the window is resized
au VimResized * :wincmd =

" allow unsaved background buffers and remember marks/undo for them
set hidden
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
" remember more commands and search history
set history=1000
" use muchos levels of undo
set undolevels=200
" save up to 100 marks, enable capital marks
set viminfo='100,f1
" disable cursor blink
set gcr=a:blinkon0
" no sounds
set visualbell
" Disable error bells
set noerrorbells
" reload files changed outside vim
set autoread

" use multiple of shiftwidth when indenting with '<' and '>'
set shiftround
set softtabstop=2
set autoindent
set smartindent
set smarttab

" Make tabs as wide as two spaces
set tabstop=2
set shiftwidth=2
set expandtab

set laststatus=2
set showmatch
set incsearch
set hlsearch
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
" highlight current line
set cursorline

" Show "invisible" characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
" Display tabs and trainling spacing visually
set list listchars=tab:▸\ ,trail:·,eol:¬
set list
set fillchars=diff:⣿,vert:│

set cmdheight=2
set switchbuf=useopen
set winwidth=79
set colorcolumn=82 " Show a colored column at 85 characters
" Enable line numbers
set number
set numberwidth=5
set showtabline=1 " show only if there is atleast two tabs (default value)
" Use relative line numbers
if exists("&relativenumber")
  set relativenumber
  au BufReadPost * set relativenumber
endif

" This makes RVM work inside Vim. I have no idea why.
set shell=bash
" Prevent Vim from clobbering the scrollback buffer
set t_ti= t_te=


" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=10


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Scrolling
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keep more context when scrolling off the end of a buffer
set scrolloff=8
set sidescrolloff=15
set sidescroll=1

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start
" Display incomplete commands
set showcmd
set complete=.,b,u,]
set completeopt=menu,preview
" Enhance command-line completion
set wildmenu
set wildmode=longest,list:longest
" Allow cursor keys in insert mode
set esckeys
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Don't add empty newlines at the end of files
set binary
set noeol


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Swap Files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set noswapfile
set nobackup
set nowb


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Persistent Undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keep undo history across sessions, by storing in file.
silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile

set nowrap    " Don't wrap lines
set linebreak " Wrap lines at convenient points


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folds
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldmethod=indent   " fold based on indent
set foldnestmax=3       " deepest fold is 3 levels
set nofoldenable        " don't fold by default


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Status Line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title

" Strip trailing whitespace (,ss)
function! StripWhitespace()
        let save_cursor = getpos(".")
        let old_query = getreg('/')
        :%s/\s\+$//e
        call setpos('.', save_cursor)
        call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom autocmds
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Automatic commands
if has("autocmd")
        " Enable file type detection
        filetype on
        " Treat .json files as .js
        autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript

        autocmd filetype html,xml set listchars-=tab:>.
        
        " Auto clear fugitive buffers
        autocmd BufReadPost fugitive://* set bufhidden=delete

        autocmd User fugitive
                \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
                \   nnoremap <buffer> .. :edit %:h<CR> |
                \ endif
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc key maps
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>y "*y
" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
" Insert a hash rocket with <c-l>
imap <c-l> <space>=><space>
imap <c-c> <esc>
" Clear the search buffer when hitting return
function! MapCR()
  nnoremap <cr> :nohlsearch<cr>
endfunction
call MapCR()

nnoremap <leader><leader> <c-^>

nnoremap <F5> :GundoToggle<cr>

" Git bindings
nnoremap <leader>l :Shell git gl -18<cr>:wincmd \|<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Multipurpose tab key
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indent if we're at the beginning of a line. Else, do completion.
function! InsertTabWrapper(direction)
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  elseif "backward" == a:direction
    return "\<C-P>"
  else
    return "\<c-n>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper("forward")<cr>
inoremap <s-tab> <c-r>=InsertTabWrapper("backward")<cr>
inoremap <s-tab> <c-n>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Open files in directory of current file
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap && <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color Scheme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("gui_running")
  let g:solarized_termtrans = 1
  set background=dark
  colorscheme base16-tomorrow
  set guioptions-=r
  set guioptions-=L
  set guifont=Menlo:h11
  " set guifont=Menlo\ for\ Powerline:h11
  set lines=60
  set columns=90
  " set cursor background to white and foreground to black in command mode
  highlight Cursor guifg=black guibg=white
else
  let g:solarized_termcolors = 256
  set background=dark
  let g:hybrid_use_Xresources = 1
  colorscheme hybrid
  "colorscheme Tomorrow-Night-Bright
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Rename current file
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>n :call RenameFile()<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Execute in Shell
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:ExecuteInShell(command) " {{{
    let command = join(map(split(a:command), 'expand(v:val)'))
    let winnr = bufwinnr('^' . command . '$')
    silent! execute  winnr < 0 ? 'botright vnew ' . fnameescape(command) : winnr . 'wincmd w'
    setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap nonumber
    echo 'Execute ' . command . '...'
    silent! execute 'silent %!'. command
    silent! redraw
    silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
    silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>:AnsiEsc<CR>'
    silent! execute 'nnoremap <silent> <buffer> q :q<CR>'
    silent! execute 'AnsiEsc'
    echo 'Shell command ' . command . ' executed.'
endfunction " }}}
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)
nnoremap <leader>! :Shell 


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Open Changed Files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Open a split for each dirty file in git
function! OpenChangedFiles()
  only " Close all windows, unless they're modified
  let status = system('git status -s | grep "^ \?(M\|A\|UU\)" | sed "s/^.\{3\}//"')
  let filenames = split(status, "\n")
  exec "edit " . filenames[0]
  for filename in filenames[1:]
    exec "sp " . filename
  endfor
endfunction
command! OpenChangedFiles :call OpenChangedFiles()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Insert Time
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! InsertTime :normal a<c-r>=strftime('%F %H:%M:%S.0 %z')<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maps to jump to specific command-t targets and files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>gr :topleft :split config/routes.rb<cr>
function! ShowRoutes()
  " Requires 'scratch' plugin
  :topleft 100 :split __Routes__
  " Make sure Vim doesn't write __Routes__ as a file
  :set buftype=nofile
  " Delete everything
  :normal 1GdG
  " Put routes output in buffer
  :0r! rake -s routes
  " Size window to number of lines (1 plus rake output length)
  :exec ":normal " . line("$") . "^W_ "
  " Move cursor to bottom
  :normal 1GG
  " Delete empty trailing line
  :normal dd
endfunction
map <leader>gR :call ShowRoutes()<cr>
map <leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>
map <leader>gc :CommandTFlush<cr>\|:CommandT app/controllers<cr>
map <leader>gm :CommandTFlush<cr>\|:CommandT app/models<cr>
map <leader>gh :CommandTFlush<cr>\|:CommandT app/helpers<cr>
map <leader>gl :CommandTFlush<cr>\|:CommandT lib<cr>
map <leader>gp :CommandTFlush<cr>\|:CommandT public<cr>
map <leader>gs :CommandTFlush<cr>\|:CommandT public/stylesheets/sass<cr>
map <leader>gf :CommandTFlush<cr>\|:CommandT features<cr>
map <leader>gg :topleft 100 :split Gemfile<cr>
map <leader>gt :CommandTFlush<cr>\|:CommandTTag<cr>
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
map <leader>F :CommandTFlush<cr>\|:CommandT %%<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Powerline config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" By some reason plugins/settings/powerline.vim doesn't work correctly {{{1
let g:Powerline_symbols="fancy"
let g:Powerline_theme="skwp"
let g:Powerline_colorscheme="skwp"

set laststatus=2 " always show the statusline
call Pl#Theme#InsertSegment('ws_marker', 'after', 'lineinfo')

set expandtab

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim R Plugin config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let vimrplugin_term_cmd = "~/bin/dt"
let vimrplugin_only_in_tmux = 1
let vimrplugin_screenplugin = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vimux
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:VimuxUseNearestPane = 1
" turbux
"let g:no_turbux_mappings = 1
"map <leader>o <Plug>SendTestToTmux
"map <leader>O <Plug>SendFocusedTestToTmux
"

nmap <F8> :TagbarToggle<CR>
