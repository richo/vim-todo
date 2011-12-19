" Vim syntax file
" Language: Todo
" Maintainer: Rich Healey <richo@psych0tik.net>
" Filenames: *.todo
" Last Change: 2011 Dec 19
" Credit goes out to @tpope, this is largely based on his todo.vim file

if exists("b:current_syntax")
  finish
endif

syn match todoHeadingRule "^[=-]\+$" contained

syn region todoCode matchgroup=todoCodeDelimiter start="``` \=" end=" \=```" keepend contains=todoLineStart


" TODO This needs to sort itself out automaticcally
function! TodoCodeHighlightSnip(filetype,start,end,textSnipHl) abort "{{{
  let ft=toupper(a:filetype)
  let group='textGroup'.ft
  if exists('b:current_syntax')
    let s:current_syntax=b:current_syntax
    " Remove current syntax definition, as some syntax files (e.g. cpp.vim)
    " do nothing if b:current_syntax is defined.
    unlet b:current_syntax
  endif
  execute 'syntax include @'.group.' syntax/'.a:filetype.'.vim'
  try
    execute 'syntax include @'.group.' after/syntax/'.a:filetype.'.vim'
  catch
  endtry
  if exists('s:current_syntax')
    let b:current_syntax=s:current_syntax
  else
    unlet b:current_syntax
  endif
  execute 'syntax region textSnip'.ft.'
  \ matchgroup='.a:textSnipHl.'
  \ start="'.a:start.'" end="'.a:end.'"
  \ contains=@'.group.'
  \ containedin=ALL'
  " XXX ^^ This is needed for PHP, everything in a <?PHP ... ?> block is part
  " of a highlighting group, which breaks the rule as per vanilla in the wiki.
endfunction "}}}

"TODO Make this happen dynamically
call TodoCodeHighlightSnip('python', '```python', '```', 'SpecialComment')
call TodoCodeHighlightSnip('ruby', '```ruby', '```', 'SpecialComment')
call TodoCodeHighlightSnip('php', '```php', '```', 'SpecialComment')
call TodoCodeHighlightSnip('bash', '```bash', '```', 'SpecialComment')
call TodoCodeHighlightSnip('sh', '```sh', '```', 'SpecialComment')
call TodoCodeHighlightSnip('erlang', '```erlang', '```', 'SpecialComment')

hi def link todoHeadingRule           todoRule
hi def link todoRule                  PreProc

hi def link todoCodeDelimiter         Delimiter


