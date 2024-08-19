set rtp+=~/.vim/bundle/fzf
set rtp+=~/.vim/bundle/fzf.vim
set rtp+=~/.vim/bundle/supertab
set rtp+=~/.vim/bundle/salesforce-vim
set rtp+=~/.vim/bundle/editorconfig-vim

let $FZF_DEFAULT_COMMAND='ag -g ""'

syntax on
filetype plugin on
set nocp sw=4 sts=4 ts=4 et ai ci si
set hls incsearch smartcase ignorecase
set modeline
set modelines=2
set bs=2
set wildchar=<Tab> wildmenu wildmode=full
set hidden
set laststatus=2
set mouse=a

colo nox

set statusline=
set statusline+=\ %n              "buffer number
set statusline+=\ %<%F            "full path
set statusline+=%m                "modified flag
set statusline+=%=%l              "current line
set statusline+=/%L               "total lines
set statusline+=\ %c%V\           "virtual column number
set statusline+=0x%04B\           "character under cursor
set statusline+=%y\               "file type
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set showbreak=↪\ 
set list

nnoremap <Space> :noh<Enter>
nnoremap <Leader>a :Files<Enter>
nnoremap <Leader>b :Buffers<Enter>

nnoremap <Leader>k :call search('\%' . virtcol('.') . 'v\S', 'bW')<Enter>
nnoremap <Leader>j :call search('\%' . virtcol('.') . 'v\S', 'wW')<Enter>

" Italic support for Mac terminal
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

let g:SuperTabDefaultCompletionType='context'

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

set timeoutlen=1000
set ttimeoutlen=1

let g:fzf_layout = { 'down': '40%' }

for d in [ "backup", "swap", "undo" ]
    if !isdirectory($HOME . "/.vim/" . d)
        call mkdir($HOME . "/.vim/" . d, "p")
    endif
endfor

set backupdir=~/.vim/backup
set directory=~/.vim/swap
set undodir=~/.vim/undo

function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun

if filereadable($HOME . "/.vimrc.local")
    source ~/.vimrc.local
endif
