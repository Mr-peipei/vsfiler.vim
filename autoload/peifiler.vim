

" ファイルタイプがファイルならそのまま、それ以外なら/をつける
function! s:name(base, v) abort
  let l:type = a:v['type']
  if l:type ==# 'link' || l:type ==# 'junction'
    if isdirectory(resolve(a:base .. a:v['name']))
      let l:type = 'dir'
    endif
  elseif l:type ==# 'linkd'
    let l:type = 'dir'
  endif
  return a:v['name'] .. (l:type ==# 'dir' ? '/' : '')
endfunction


function! peifiler#init() abort
    let l:path = resolve(expand('%:p'))
    if !isdirectory(l:path)
        return 
    endif
    let l:dir = fnamemodify(l:path, ':p:gs!\!\!')
    if isdirectory(l:dir) && l:dir !~# '/$'
        let l:dir .= '/'
    endif

    let b:now_dir = l:dir
    setlocal modifiable
    setlocal filetype=peifiler buftype=nofile bufhidden=unload nobuflisted noswapfile
    setlocal nowrap cursorline

    " s:nameに{'type': 'file', 'name': 'filename'}の形で渡す
    let l:files=map(readdir(l:path, '1'), {_, v-> s:name(l:dir, {'type': getftype(l:dir .. '/' .. v), 'name':v})})

    " dotfileを表示するかどうか
    if !get(b:, 'molder_show_hidden', get(g:, 'molder_show_hidden', 0))
      call filter(l:files, 'v:val =~# "^[^.]"')
    silent keepmarks keepjumps call setline(1, l:files)
    endif

    silent keepmarks keepjumps call setline(1, l:files)
    setlocal nomodified nomodifiable

endfunction

function! peifiler#openv() abort
    let l:path = resolve(expand('%:p:h'))
    " if !isdirectory(l:path)
    "     return 
    " endif
    let l:dir = fnamemodify(l:path, ':p:gs!\!\!')
    if isdirectory(l:dir) && l:dir !~# '/$'
        let l:dir .= '/'
    endif
    let s:buf=bufnr('%')
    let s:winid=win_getid()
    topleft vnew     
    vertical-resize 40
    let b:now_dir = l:dir
    setlocal modifiable
    setlocal filetype=peifiler buftype=nofile bufhidden=unload nobuflisted noswapfile
    setlocal nowrap cursorline
    let l:files=map(readdir(l:path, '1'), {_, v-> s:name(l:dir, {'type': getftype(l:dir .. '/' .. v), 'name':v})})
    silent keepmarks keepjumps call setline(1, l:files)
    let s:filerbuf=bufnr('%')
    let s:filerwinid=win_getid()
endfunction


function! peifiler#open() abort
  let l:edit_dir = b:now_dir .. substitute(getline('.'), '/$', '', '')
  if isdirectory(l:edit_dir)
    exe 'edit' fnameescape(l:edit_dir)
  else
    call win_gotoid(s:winid)
    exe 'edit' fnameescape(l:edit_dir)
    call win_gotoid(s:filerwinid)
    quit
  endif
endfunction


function! peifiler#up() abort
  let l:dir = substitute(b:now_dir, '/$', '', '')
  let l:name = fnamemodify(l:dir, ':t:gs!\!/!')
  if empty(l:name)
    return
  endif
  let l:dir = fnamemodify(l:dir, ':p:h:h:gs!\!/!')
  exe 'edit' fnameescape(l:dir)
  call search('\v^\V' .. escape(l:name, '\') .. '/\v$', 'c')
endfunction


function! peifiler#close() abort
  call win_gotoid(s:filerwinid)
  quit
endfunction
