if exists('b:current_syntax')
  finish
endif

syn match peifilerDirectory '^.\+/$'

hi! def link peifilerDirectory Directory

let b:current_syntax = 'peifiler'
