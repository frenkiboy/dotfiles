" Filetype plugin for research plan documents

setlocal wrap
setlocal linebreak
setlocal textwidth=0
setlocal tabstop=4
setlocal shiftwidth=4
setlocal foldmethod=expr
setlocal foldexpr=getline(v:lnum)=~'^[A-Z].*:$'?'>1':getline(v:lnum)=~'^\\d\\+\\.'?'>2':'='
setlocal foldlevel=99
setlocal conceallevel=0
setlocal nospell
setlocal cursorline
