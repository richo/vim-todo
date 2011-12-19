" Vim filetype plugin
" Language:     todo
" Maintainer:       Rich Healey <richo@psych0tik.net>
" Last Change:      2011 Dec 19

if exists("b:did_ftplugin")
  finish
endif

runtime! ftplugin/html.vim ftplugin/html_*.vim ftplugin/html/*.vim
unlet! b:did_ftplugin

setlocal formatoptions+=tcqln

" vim:set sw=2:

