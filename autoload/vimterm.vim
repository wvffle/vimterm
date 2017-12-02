let s:vimterm_window = -1
let s:vimterm_buf = -1

function! vimterm#open()
  if s:vimterm_buf == -1 || !bufexists(s:vimterm_buf)
    sp | wincmd j
    execute 'resize ' . g:vimterm_height
    term
    set nobuflisted
    let s:vimterm_buf = bufnr('%')
    let s:vimterm_window = win_getid()
  else
    if !win_gotoid(s:vimterm_window)
      sp | wincmd j
      execute 'resize ' . g:vimterm_height
      let s:vimterm_window = win_getid()
    endif
    exec 'silent buffer ' . s:vimterm_buf
    startinsert
  endif
endfunction

function! vimterm#close()
  if win_gotoid(s:vimterm_window)
    hide
  endif
endfunction

function! vimterm#kill()
  if win_gotoid(s:vimterm_window)
    quit
    let s:vimterm_window = -1
    let s:vimterm_buf = -1
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
  if !win_gotoid(s:vimterm_window)
    call vimterm#open()
  endif

  exec bufwinnr(s:vimterm_buf) . "wincmd w"
  let rreg = @v
  call setreg('v', a:cmd . "\n\n", 'b')
  put v
  let @v = rreg
  startinsert
endfunction
