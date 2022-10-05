
function map_(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map_('n', shortcut, command)
end

function imap(shortcut, command)
  map_('i', shortcut, command)
end

function vmap(shortcut, command)
  map_('v', shortcut, command)
end

function cmap(shortcut, command)
  map_('c', shortcut, command)
end

function tmap(shortcut, command)
  map_('t', shortcut, command)
end


vim.g.mapleader = " "

-- leader combos
-- b: bookmarks
-- c: general vim (edit/source rcfile, quick fix, ...)
-- g: lsp commands
-- d: debug
-- f: file (or buffer)
-- s: search
-- v: version control (git)
-- w: window
-- n: notes
nmap('<leader>b', '<nop>')
nmap('<leader>c', '<nop>')
nmap('<leader>d', '<nop>')
nmap('<leader>f', '<nop>')
nmap('<leader>g', '<nop>')
nmap('<leader>s', '<nop>')
nmap('<leader>v', '<nop>')
nmap('<leader>w', '<nop>')
nmap('<leader>n', '<nop>')


-- vimrc
vim.cmd([[
execute 'nnoremap <silent> <leader>ce :edit'   $MYVIMRC . '<cr>'
execute 'nnoremap <silent> <leader>cs :source' $MYVIMRC . '<cr>'
]])

-- escape
imap('<C-l>', '<Esc>')
vmap('<C-l>', '<Esc>')
cmap('<C-l>', '<C-c>')
tmap('<Esc>', '<C-\\><C-n>')
tmap('<C-l>', '<C-\\><C-n>')

-- exit
nmap('<F8>', ':qa<CR>')

-- stop from hitting F1 by accident
imap('<F1>', '<Esc>')
vmap('<F1>', '<Esc>')

-- turn off highlighted search
nmap('<C-N>', ':noh<CR>')

-- window focus
--nmap('<leader>h', '<C-W>h')
--nmap('<leader>j', '<C-W>j')
--nmap('<leader>k', '<C-W>k')
--nmap('<leader>l', '<C-W>l')

-- window size
nmap('<leader>l', '20<C-W>>')
nmap('<leader>h', '20<C-W><')
nmap('<leader>k', '5<C-W>-')
nmap('<leader>j', '5<C-W>+')
nmap('<leader>L', '40<C-W>>')
nmap('<leader>H', '40<C-W><')

-- movements
nmap('J', '}')
vmap('J', '}')
nmap('K', '{')
vmap('K', '{')

nmap('Q', 'J')
vmap('Q', 'J')

-- yank the current file name
vim.cmd([[
:nnoremap <silent> <leader>fy :let @+ = expand("%")<cr>
]])

-- Quick Fix
nmap('<leader>co', ':copen<CR>')
nmap('<leader>cc', ':cclose<CR>')
nmap('<leader>cn', ':cnext<CR>')


-- clang-format
local clangformat = '/home/frank/opt/share/clang/clang-format.py'
nmap('<c-K>', ':py3f ' .. clangformat .. '<cr>')
vmap('<c-K>', ':py3f ' .. clangformat .. '<cr>')
imap('<c-K>', '<c-o>:py3f ' .. clangformat .. '<cr>')

-- notes
nmap('<leader>nn', ':e /home/frank/notes/index.md<cr>')
nmap('<leader>ns', ':e /home/frank/notes/scratch.md<cr>')
nmap('<leader>nt', ':e /home/frank/notes/todo.md<cr>')
