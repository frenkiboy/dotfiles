" Vim syntax file for research plan documents
if exists("b:current_syntax")
  finish
endif

syntax clear

" ── Headers: lines ending with colon ──────────────────────
" Color the whole line text
syntax match rpHeader /^.\+:\s*$/

" ── Tab-dash lists: lines starting with tab(s) then dash ──
" Color only the dash
syntax match rpDash /^\t\+\zs-/

" ── Numbered items: first non-space char is a digit ───────
" Color the number + attached letters + dot (e.g. 1. 1a. 1b. 2b)
syntax match rpNumber /^\s*\zs\d\+[a-z]*[.]\?/

" ── Colors (8-color safe) ─────────────────────────────────
highlight rpHeader ctermfg=Red    cterm=bold guifg=#af5f5f gui=bold
highlight rpDash   ctermfg=Cyan   cterm=bold guifg=#87af87 gui=bold
highlight rpNumber ctermfg=Yellow cterm=bold guifg=#af875f gui=bold

let b:current_syntax = "researchplan"
