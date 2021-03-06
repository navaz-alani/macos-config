" =============== Custom =================== "
" need these to maintain sanity
:map :W :w
:map :Q :q
" double tab to write file
nnoremap <Tab><Tab> :w<CR>

" =============== Plugins =================== "
call plug#begin()

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim'
Plug 'vim-syntastic/syntastic'
Plug 'tomasr/molokai'
Plug 'lervag/vimtex'
Plug 'PaperMountainStudio/modernized-vim'
Plug 'rust-lang/rust.vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'ianks/vim-tsx'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'unblevable/quick-scope'

" color schemes
Plug 'morhetz/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'kyoz/purify', { 'rtp': 'vim' }

call plug#end()

" =============== Config ==================== "
set number         " Show line numbers
set relativenumber " Relative line numbering for easier vertical navigation
set history=1000   " Store more history
set showcmd        " Show incomplete cmds
set showmode       " Show current mode
set visualbell     " No sound
set hidden         " Allow buffers to be hidden without writing to the disk
set textwidth=80   " Hard wrap at 80 characters
syntax on          " Turn on syntax highlighting

" ================ Indentation ====================== "

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

filetype plugin indent on

" Display whitespace errors as `.'
set list listchars=tab:\ \ ,trail:.

set nowrap    " Do not wrap lines
set linebreak " Wrap lines when convenient

" =============== Folds / wrapping =============== "

set foldmethod=indent   " Fold based on indent
set foldnestmax=3       " Deepest fold is 3 levels
set nofoldenable        " Don't fold by default

" Highlight long lines
if exists('+colorcolumn')
  set colorcolumn=+1
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif


" ============== Use Gitignore ============== "
let gitignore = '.gitignore'
"let gitignore = 'ignore_this_block'
if filereadable(gitignore)
  let igstring = ''
  for oline in readfile(gitignore)
    let line = substitute(oline, '\s|\n|\r', '', "g")
    if line =~ '^#' | con | endif
    if line == '' | con  | endif
    if line =~ '^!' | con  | endif
    if line =~ '/$' | let igstring .= "," . line . "*" | con | endif
    let igstring .= "," . line
  endfor
  let execstring = "set wildignore+=".substitute(igstring, '^,', '', "g")
  execute execstring
endif

" ================ Search Settings  ================= "

set incsearch  " Highlight as you search
set hlsearch   " Highlight the current search
set ignorecase " Make search case insensitive...
set smartcase  " ... except when we use uppercase letters

" =========== Custom Commands and keys  ============= "
:command ToJSON %!python -m json.tool
:nmap \l :setlocal number!<CR>
:nmap \p :set paste!<CR>
:nmap j gj
:nmap k gk

" ================ Themes  ================= "
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
"colorscheme gruvbox

let g:rehash256 = 1
"colorscheme molokai

let g:airline_theme='purify'
colorscheme purify

"colorscheme dracula

" ================ Key Bindings ================= "
" Disable arrow keys - commented out because autocomplete
"for key in ['<Up>', '<Down>', '<Left>', '<Right>']
"  exec 'noremap' key '<Nop>'
"  exec 'inoremap' key '<Nop>'
"  exec 'cnoremap' key '<Nop>'
"endfor

" ================ Syntastic ================= "
let g:syntastic_cpp_compiler_options = ' -std=c++14'

" ================ Markdown ================= "
" mark checklist item done
nnoremap mdd :.s/\[ /\[X/<CR>
" mark checklist item undone
nnoremap mdu :.s/\[X/\[ /<CR>
" make current line a checklist item
nnoremap mdi <Esc>^i- [ ]<Space>
" make current line level 1 header
nnoremap md1 <Esc>Vyp:.s/./=/g<Enter>
" make current line level 2 header
nnoremap md2 <Esc>Vyp:.s/./-/g<Enter>

" ================ LaTeX ======================= "
" Create new environment with given name
function NewEnv(name)
  redir =>output
  echom "\\begin{" . a:name . "}"
  echom "\\end{" . a:name . "}"
  redir END
  put=output
endfunction
" normal mode commands to quickly create environments and align them
nnoremap Ed :call NewEnv("document")<Enter><Enter>kVj=
nnoremap Ee :call NewEnv("enumerate")<Enter><Enter>kVj=
nnoremap Ei :call NewEnv("itemize")<Enter><Enter>kVj=
nnoremap Ea :call NewEnv("align*")<Enter><Enter>kVj=
nnoremap Et :call NewEnv("tabular")<Enter><Enter>kVj=

autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
