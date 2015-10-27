"============================================================================
"File:        stylelint.vim
"Description: Syntax checking plugin for syntastic.vim using `stylelint`
"             (https://github.com/stylelint/stylelint).
"Maintainer:  Tim Carry <tim at pixelastic dot com>
"License:     This program is free software. It comes without any warranty,
"             to the extent permitted by applicable law. You can redistribute
"             it and/or modify it under the terms of the Do What The Fuck You
"             Want To Public License, Version 2, as published by Sam Hocevar.
"             See http://sam.zoy.org/wtfpl/COPYING for more details.
"
"============================================================================

if exists('g:loaded_syntastic_css_stylelint_checker')
    finish
endif
let g:loaded_syntastic_css_stylelint_checker = 1

let s:save_cpo = &cpo
set cpo&vim

function! SyntaxCheckers_css_stylelint_GetLocList() dict
    let makeprg = self.makeprgBuild({ })
    " Example output:
    " CssSyntaxError: /path/to/file.css:2:11: Missed semicolon
    " or
    " 2:11    Expected single space after ":" (declaration-colon-space-after)
    let errorformat = 
          \ 'CssSyntaxError: %f:%l:%c: %m,' .
          \ '%\m%l\:%c%\s%#%m,'

    return SyntasticMake({
        \ 'makeprg': makeprg,
        \ 'errorformat': errorformat,
        \ 'defaults': {'bufnr': bufnr('')} })
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'css',
    \ 'name': 'stylelint'})

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set sw=4 sts=4 et fdm=marker:
