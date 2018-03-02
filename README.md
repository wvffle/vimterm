# vimterm

![](https://cdn.rawgit.com/wvffle/vimterm/screenshots/waff%40nyarch2.png)

vimterm provides simple window with neovim's :terminal at the bottom of the screen.

But why? That's a good question. vimterm lets you operate with your files and have a single terminal window attached to the bottom of your workspace.
For example, you can create a mapping to compile c++ programs with g++ without leaving your best editor.

Example mappings could look like this:
```viml
nnoremap <silent> <F4> :call vimterm#run('g++  -o /tmp/out' . expand('%')) <CR>
nnoremap <silent> <F5> :call vimterm#exec('/tmp/out') <CR>

nnoremap <F7> :call vimterm#toggle() <CR>
tnoremap <F7> <C-\><C-n>:call vimterm#toggle() <CR>
```

## installation
Basically it's the same as every other plugin, so you can use dein for that:
```viml
call dein#add('wvffle/vimterm')
```

## screenshots
![](https://cdn.rawgit.com/wvffle/vimterm/screenshots/waff%40nyarch2.png)
![](https://cdn.rawgit.com/wvffle/vimterm/screenshots/waff%40nyarch.png)
![](https://cdn.rawgit.com/wvffle/vimterm/screenshots/git.png)
