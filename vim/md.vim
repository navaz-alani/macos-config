" mark checklist item done
nnoremap mdd :.s/\[ /\[X/<CR>
" mark checklist item undone
nnoremap mdu :.s/\[X/\[ /<CR>
" make current line a checklist item
nnoremap mdi <Esc>^i- [ ]<Space>
" make current line level 1 header
nnoremap md1 <Esc>Vyp:.s/./=/g<Enter>
" make current line level 2 header
nnoremap md2 <Esc>Vyp:.s/./-/g<Enter>

