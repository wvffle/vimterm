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
<<<<<<< HEAD
  if win_gotoid(s:vimterm_window)
    call vimterm#close()
  else
    sp | wincmd j
    execute 'resize ' . g:vimterm_height
    call termopen(a:cmd)
    set nobuflisted
    startinsert
  endif
=======
  call vimterm#close()
  new vimtermtmp | q | sp | wincmd j | b vimtermtmp
  execute 'resize ' .  g:vimterm_height
  call termopen(a:cmd)
  let s:vimterm_window = win_getid()
  startinsert
>>>>>>> 159057601645316a842806cb6b4b9bf42cc6f33c
endfunction
