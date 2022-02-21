
command! PeiFiler call peifiler#init()
command! PeiFilerv call peifiler#openv()

nnoremap <silent><C-m> :<c-u>call peifiler#openv()<cr>


function! s:shutup_netrw() abort
  if exists('#FileExplorer')
    autocmd! FileExplorer *
  endif
  if exists('#NERDTreeHijackNetrw')
    autocmd! NERDTreeHijackNetrw *
  endif
endfunction

augroup _peifiler_
  autocmd!
  autocmd VimEnter * call s:shutup_netrw()
  autocmd BufEnter * call peifiler#init()
augroup END
