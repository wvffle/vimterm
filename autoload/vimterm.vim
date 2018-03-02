let s:vimterm_job_id = -1
let s:vimterm_window = -1
let s:vimterm_buf = -1

function! vimterm#init()
  
endfunction

function! vimterm#init()
  new vimterm
  exec 'resize ' . g:vimterm_height
  set nobuflisted

  let s:vimterm_job_id = termopen($SHELL, { 'detach': 1 })
  let s:vimterm_buf = bufnr('%')
  let s:vimterm_window = win_getid()
endfunction

function! vimterm#open()
  if s:vimterm_job_id == -1
    " if not initialized then init
    call vimterm#init()
  else
    " if there is no buffer then reset all variables
    if !bufexists(s:vimterm_buf)
      call vimterm#kill()
      call vimterm#open()
      return
    endif

    if !win_gotoid(s:vimterm_window)
      sp | wincmd J
      exec 'resize ' . g:vimterm_height

      let s:vimterm_window = win_getid()
    endif

    exec 'silent buffer ' . s:vimterm_buf
  endif

  " clear current input
  call jobsend(s:vimterm_job_id, "\<c-e>\<c-u>")

  startinsert
endfunction

function! vimterm#close()
  if win_gotoid(s:vimterm_window)
    hide
  endif
endfunction

function! vimterm#kill()
  let s:vimterm_window = -1
  let s:vimterm_buf = -1
  let s:vimterm_job_id = -1

  if win_gotoid(s:vimterm_window)
    quit
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

  " clear current input
  call jobsend(s:vimterm_job_id, "\<c-e>\<c-u>")

  " run cmd
  call jobsend(s:vimterm_job_id, a:cmd . "\n")

  " scroll down
  normal G

  " start insert
  startinsert
endfunction

function! vimterm#run(cmd)
  if !bufexists(s:vimterm_buf)
    call vimterm#init()
    call vimterm#close()
  endif

  " clear current input
  call jobsend(s:vimterm_job_id, "\<c-e>\<c-u>")

  " run cmd
  call jobsend(s:vimterm_job_id, a:cmd . "\n")
endfunction
