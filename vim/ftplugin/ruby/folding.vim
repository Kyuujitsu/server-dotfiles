if &filetype != 'ruby'
  finish
end

setlocal foldmethod=syntax
setlocal foldtext=RubyFoldText()

function! RubyFoldText()
  let fs = v:foldstart
  while getline(fs) =~ '^\s*@' | let fs = nextnonblank(fs + 1)
  endwhile
  let line = getline(fs)

  let nucolwidth = 79
  let windowwidth = 82
  let foldedlinecount = v:foldend - v:foldstart

  " expand tabs into spaces
  let onetab = strpart('  ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')

  let line = strpart(line, 0, windowwidth - 2 - len(foldedlinecount))
  let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
  return line . '…' . repeat(" ", fillcharcount) . foldedlinecount . '…' . ' '
endfunction

highlight Folded term=bold ctermfg=8 guifg=#969896 guibg=#1d1f21
highlight FoldColumn term=bold ctermfg=8 guifg=#969896
