
let s:flag = 0

function! s:sort(lhs, rhs) abort
  if a:lhs[-1:] ==# '/' && a:rhs[-1:] !=# '/'
    return -1
  elseif a:lhs[-1:] !=# '/' && a:rhs[-1:] ==# '/'
    return 1
  endif
  if a:lhs < a:rhs
    return -1
  elseif a:lhs > a:rhs
    return 1
  endif
  return 0
endfunction

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


function! vsfiler#init() abort
    let l:path = resolve(expand('%:p'))
    if !isdirectory(l:path)
        return 
    endif
    let l:dir = fnamemodify(l:path, ':p:gs!\!\!')
    if isdirectory(l:dir) && l:dir !~# '/$'
        let l:dir .= '/'
    endif

    let s:now_dir = l:dir
    setlocal modifiable
    setlocal filetype=vsfiler buftype=nofile bufhidden=unload nobuflisted noswapfile
    setlocal nowrap cursorline

    " s:nameに{'type': 'file', 'name': 'filename'}の形で渡す
    let l:files=map(readdir(l:path, '1'), {_, v-> s:name(l:dir, {'type': getftype(l:dir .. '/' .. v), 'name':v})})

    silent keepmarks keepjumps call setline(1, sort(l:files, function('s:sort')))
    setlocal nomodified nomodifiable
endfunction

function! vsfiler#initv() abort
    if s:flag ==# 1
      call win_gotoid(s:filerwinid)
      return
    endif
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
    let s:flag = 1
    vertical-resize 30
    let s:now_dir = l:dir
    echo s:now_dir
    setlocal modifiable
    setlocal filetype=vsfiler buftype=nofile bufhidden=unload nobuflisted noswapfile
    setlocal nowrap cursorline
    let l:files=map(readdir(l:path, '1'), {_, v-> s:name(l:dir, {'type': getftype(l:dir .. '/' .. v), 'name':v})})
    silent keepmarks keepjumps call setline(1, sort(l:files, function('s:sort')))
    let s:filerbuf=bufnr('%')
    let s:filerwinid=win_getid()
endfunction


function! vsfiler#open() abort
  let l:edit_dir = s:now_dir .. substitute(getline('.'), '/$', '', '')
  if isdirectory(l:edit_dir)
    exe 'edit' fnameescape(l:edit_dir)
    let s:now_dir = fnameescape(l:edit_dir) .. '/'
    echo s:now_dir
  else
    call win_gotoid(s:winid)
    exe 'edit' fnameescape(l:edit_dir)
    call win_gotoid(s:filerwinid)
    let s:flag = 0
    quit
  endif
endfunction


function! vsfiler#up() abort
  let l:dir = substitute(s:now_dir, '/$', '', '')
  let l:name = fnamemodify(l:dir, ':t:gs!\!/!')
  if empty(l:name)
    return
  endif
  let l:dir = fnamemodify(l:dir, ':p:h:h:gs!\!/!')
  exe 'edit' fnameescape(l:dir)
  let s:now_dir = fnameescape(l:dir) .. '/'
  echo s:now_dir
  call search('\v^\V' .. escape(l:name, '\') .. '/\v$', 'c')
endfunction

function! vsfiler#close() abort
  call win_gotoid(s:filerwinid)
  let s:flag = 0
  quit
endfunction

function! vsfiler#reload() abort
  exe 'edit' fnameescape(s:now_dir)
endfunction

function! vsfiler#curdir() abort
  return get(b:, 'now_dir', '')
endfunction

function! vsfiler#error(msg) abort
  redraw
  echohl Error
  echomsg a:msg
  echohl None
endfunction

function! vsfiler#newdir() abort
  let l:name = input('New directory: ')
  try
    if mkdir(s:now_dir .. l:name) ==# 0
      throw 'failed'
    endif 
  catch
    call vsfiler#error('Create directory filed')
    return
  endtry
  call vsfiler#reload()
endfunction

function! vsfiler#newfile() abort
  let l:name = input('New file: ')
  try
    call win_gotoid(s:winid)
    exe 'edit' s:now_dir ..l:name
    write
  catch
    call vsfiler#error('Create file filed')
    return
  endtry
  call win_gotoid(s:filerwinid)
  call vsfiler#reload()
  call win_gotoid(s:winid)
endfunction


function! vsfiler#delete() abort
  let l:name = getline('.')
  if confirm('Delete?: ' .. l:name, "&Y\n&n\n", 2) ==# 2
    return
  endif
  let l:path = s:now_dir .. l:name
  if isdirectory(l:path)
    try
      if delete(l:path, 'rf') == -1
        throw 'failed'
      endif
    catch
      call vsfiler#error('Delete directory failed')
      return
    endtry
    echo 'Delete successful'
  else
    try
      if delete(l:path) == -1
        throw 'failed'
      endif
    catch
      call vsfiler#error('Delete directory failed')
      return
    endtry
  endif
  call vsfiler#reload()
endfunction



