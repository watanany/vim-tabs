let s:save_cpo = &cpo
set cpo&vim


function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

function! s:tabline()
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction

let &tabline = '%!'. s:SID_PREFIX() . 'tabline()'

" select tab with numbers(1..9)
for n in range(1, 9)
  execute 'nnoremap <silent> t'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

" tc create new tab
nnoremap <silent> tc :tablast <bar> tabnew<CR>
" tx close tab
nnoremap <silent> tx :tabclose<CR>
" tn select next tab
nnoremap <silent> tn :tabnext<CR>
" tp select previous tab
nnoremap <silent> tp :tabprevious<CR>


let &cpo = s:save_cpo
unlet s:save_cpo
