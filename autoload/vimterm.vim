let s:vimterm_job_id = -1
let s:vimterm_window = -1
let s:vimterm_buf = -1

function! vimterm#open()
  if s:vimterm_job_id == -1
    new vimterm | wincmd J
    exec 'resize ' . g:vimterm_height

    let s:vimterm_job_id = termopen($SHELL, { 'detach': 1 })
    let s:vimterm_buf = bufnr('%')
    let s:vimterm_window = win_getid()

    set nobuflisted
  else
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
  if win_gotoid(s:vimterm_window)
    quit
    let s:vimterm_window = -1
    let s:vimterm_buf = -1
    let s:vimterm_job_id = -1
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
  startinsert
endfunction
