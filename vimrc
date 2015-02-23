set nocompatible
execute pathogen#infect()
filetype plugin indent on

syntax on
set background=light

colorscheme solarized

set list listchars=tab:»·,trail:·,eol:$
set autowrite
set backup
set backupdir=~/.vim/backup
set backupext=~
set dir=~/.vim/swap
set hlsearch
set ic
set incsearch
set number
set ruler
set sm
set smartcase
set tabstop=2
set shiftwidth=2
set expandtab
set visualbell
set wrap
set shm=filmnrwxt
set backspace=indent,eol,start
set nojoinspaces
set wildmode=longest,list:full
set mouse=a
set completeopt=menu,longest
set laststatus=2
set statusline=%f%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set paste
set autoindent
set smartindent
set showcmd
set colorcolumn=80
set wildignore=*/tmp/*,*/log/*,*/.git/*,*/vendor/*
set wildignore+=*/b/*,*/public/assets/*,*/app/assets/images/*,*/public/system/*

"hi OverLength ctermbg=none cterm=none
"match OverLength /\%>80v/
fun! s:LongLineHLToggle()
 if !exists('w:longlinehl')
  let w:longlinehl = matchadd('ErrorMsg', '.\%>80v', 0)
  echo "Long lines highlighted"
 else
  call matchdelete(w:longlinehl)
  unl w:longlinehl
  echo "Long lines unhighlighted"
 endif
endfunction

let mapleader=","
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': [], 'passive_filetypes': ['scss', 'cucumber'] }
let g:syntastic_ruby_checkers=['mri']
let g:syntastic_javascript_checkers = ['jslint']
let g:rspec_command = "Dispatch rspec {spec}"

cab W w
cab Q q
cab Wq wq
cab wQ wq
cab WQ wq

noremap gf :new %:p:h/<cfile><CR>
noremap n nzz
noremap N Nzz
nnoremap <Leader>H :call<SID>LongLineHLToggle()<cr>
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

nmap <BS> :noh<CR>
nmap ,b :CtrlPBuffer<CR>
nmap ,f :CtrlPCurWD<CR>
nmap <Space> <PageDown>

noremap mm o<ESC>k

" copy selection to the clipboard
vmap <Leader>cp :w !pbcopy<CR><CR>

vnoremap < <gv
vnoremap > >gv

" Rspec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

map <C-j> :bnext<CR>
map <C-k> :bprev<CR>
map <C-h> :bfirst<CR>
map <C-l> :blast<CR>
map <C-q> :bw<CR>
map :: ^

command! Sudowrite :write !sudo tee % > /dev/null
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

"hi OverLength ctermbg=none cterm=none
"match OverLength /\%>80v/
fun! s:LongLineHLToggle()
 if !exists('w:longlinehl')
  let w:longlinehl = matchadd('ErrorMsg', '.\%>80v', 0)
  echo "Long lines highlighted"
 else
  call matchdelete(w:longlinehl)
  unl w:longlinehl
  echo "Long lines unhighlighted"
 endif
endfunction

autocmd! bufwritepost .vimrc source %
autocmd FocusLost * :set number
autocmd FocusGained * :set relativenumber
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber
" Markdown
autocmd BufNewFile,BufRead *.md set spelllang=en spell filetype=markdown
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")|execute("normal `\"")|endif
autocmd BufNewFile,BufRead COMMIT_EDITMSG set spelllang=en spell

if filereadable('.vimrcustom')
  so .vimrcustom
endif
