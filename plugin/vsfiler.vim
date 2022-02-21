
command! PeiFiler call vsfiler#init()
command! PeiFilerv call vsfiler#openv()

nnoremap <silent><C-m> :<c-u>call vsfiler#openv()<cr>


function! s:shutup_netrw() abort
  if exists('#FileExplorer')
    autocmd! FileExplorer *
  endif
  if exists('#NERDTreeHijackNetrw')
    autocmd! NERDTreeHijackNetrw *
  endif
endfunction

augroup _vsfiler_
  autocmd!
  autocmd VimEnter * call s:shutup_netrw()
  autocmd BufEnter * call vsfiler#init()
augroup END
