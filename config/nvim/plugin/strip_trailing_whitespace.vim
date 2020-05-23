function StripTrailingWhitespace()
  if !&binary && &filetype != 'diff'
    normal mz
    normal Hmy
    %s/\s\+$//e
    normal 'yz<CR>
    normal `z
  endif
endfunction

" example mapping
" nmap <Leader>x <Plug>StripTrailingWhitespace
nnoremap <Plug>StripTrailingWhitespace :<C-U>call <SID>StripTrailingWhitespace()<CR>

