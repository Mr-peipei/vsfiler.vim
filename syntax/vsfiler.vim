if exists('b:current_syntax')
  finish
endif

syn match vsfilerDirectory '^.\+/$'

hi! def link vsfilerDirectory Directory

let b:current_syntax = 'vsfiler'
