nnoremap <silent> <plug>(peifiler-open) :<c-u>call peifiler#open()<cr>
nnoremap <silent> <plug>(peifiler-up) :<c-u>call peifiler#up()<cr>
nnoremap <silent> <plug>(peifiler-close) :<c-u>call peifiler#close()<cr>

if !hasmapto('<plug>(peifiler-open)')
  nmap <buffer> l <plug>(peifiler-open)
  nmap <buffer> h <plug>(peifiler-up)
  nmap <buffer> <C-m> <plug>(peifiler-close)
endif
