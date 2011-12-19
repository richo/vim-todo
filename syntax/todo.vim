" Vim syntax file
" Language: Todo
" Maintainer: Rich Healey <richo@psych0tik.net>
" Filenames: *.todo
" Last Change: 2011 Dec 19
"
" Credit goes out to @tpope, this is largely based on his markdown.vim file

if exists("b:current_syntax")
  finish
endif

runtime! syntax/html.vim
unlet! b:current_syntax

syn sync minlines=10
syn case ignore

syn match todoValid '[<>]\S\@!'
syn match todoValid '&\%(#\=\w*;\)\@!'

syn match todoLineStart "^[<@]\@!" nextgroup=@todoBlock

syn cluster todoBlock contains=todoH1,todoH2,todoBlockquote,todoListMarker,todoOrderedListMarker,todoCodeBlock,todoRule
syn cluster todoInline contains=todoLineBreak,todoLinkText,todoCode,todoEscape,@htmlTop

syn match todoH1 ".\+\n=\+$" contained contains=@todoInline,todoHeadingRule
syn match todoH2 ".\+\n-\+$" contained contains=@todoInline,todoHeadingRule

syn match todoHeadingRule "^[=-]\+$" contained

syn region todoH1 matchgroup=todoHeadingDelimiter start="##\@!"      end="#*\s*$" keepend oneline contains=@todoInline contained
syn region todoH2 matchgroup=todoHeadingDelimiter start="###\@!"     end="#*\s*$" keepend oneline contains=@todoInline contained

syn match todoBlockquote ">\s" contained nextgroup=@todoBlock

syn region todoCodeBlock start="    \|\t" end="$" contained

syn match todoLineBreak "\s\{2,\}$"

syn region todoAutomaticLink matchgroup=todoUrlDelimiter start="<\%(\w\+:\|[[:alnum:]_+-]\+@\)\@=" end=">" keepend oneline

syn region todoCode matchgroup=todoCodeDelimiter start="`" end="`" transparent keepend contains=todoLineStart
syn region todoCode matchgroup=todoCodeDelimiter start="`` \=" end=" \=``" keepend contains=todoLineStart

syn match todoEscape "\\[][\\`*_{}()#+.!-]"

hi def link todoH1                    htmlH1
hi def link todoH2                    htmlH2
hi def link todoHeadingRule           todoRule
hi def link todoHeadingDelimiter      Delimiter
hi def link todoBlockquote            Comment
hi def link todoRule                  PreProc

hi def link todoUrl                   Float
hi def link todoUrlTitle              String
hi def link todoUrlDelimiter          htmlTag
hi def link todoUrlTitleDelimiter     Delimiter

hi def link todoCodeDelimiter         Delimiter

hi def link todoEscape                Special


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
call TodoCodeHighlightSnip('sh', '```bash', '```', 'SpecialComment')
call TodoCodeHighlightSnip('sh', '```sh', '```', 'SpecialComment')
call TodoCodeHighlightSnip('erlang', '```erlang', '```', 'SpecialComment')

let b:current_syntax = "todo"
