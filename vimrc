" Enable filetype detection, plugins, and indentation
filetype plugin on
syntax on

" General usability
set number
set cursorline
set background=dark
set autoread
autocmd CursorHold,CursorHoldI,FocusGained,BufEnter * checktime
