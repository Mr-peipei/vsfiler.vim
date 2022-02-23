nnoremap <silent> <plug>(vsfiler-open) :<c-u>call vsfiler#open()<cr>
nnoremap <silent> <plug>(vsfiler-up) :<c-u>call vsfiler#up()<cr>
nnoremap <silent> <plug>(vsfiler-close) :<c-u>call vsfiler#close()<cr>
nnoremap <silent> <plug>(vsfiler-newdir) :<c-u>call vsfiler#newdir()<cr>

if !hasmapto('<plug>(vsfiler-open)')
  nmap <buffer> l <plug>(vsfiler-open)
  nmap <buffer> h <plug>(vsfiler-up)
  nmap <buffer> K <plug>(vsfiler-newdir)
  nmap <buffer> <C-m> <plug>(vsfiler-close)
endif
