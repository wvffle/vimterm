let s:vimterm_window = -1
function! vimterm#open()
  if !win_gotoid(s:vimterm_window)
    sp | wincmd j
    execute 'resize ' . g:vimterm_height
    term
    set nobuflisted
    let s:vimterm_window = win_getid()
  else
    startinsert
  endif

endfunction

function! vimterm#close()
  if win_gotoid(s:vimterm_window)
    q
  endif
endfunction

function! vimterm#toggle()
  if win_gotoid(s:vimterm_window)
    call vimterm#close()
  else
    call vimterm#open()
  endif
endfunction

function! vimterm#exec(cmd)
  if win_gotoid(s:vimterm_window)
    call vimterm#close()
  else
    new vimterm | set nobuflisted | wincmd j
    execute 'resize ' . g:vimterm_height
    call termopen(a:cmd)
    startinsert
  endif
endfunction
