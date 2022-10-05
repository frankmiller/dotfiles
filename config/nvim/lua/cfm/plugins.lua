
-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup Packer
    autocmd!
    "autocmd BufWritePost plugins.lua source <afile> | PackerSync
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]

local packer = require('packer')

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
})

packer.startup(function(use)
  -- common
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'

  -- style
  use {'EdenEast/nightfox.nvim'}
  use 'nvim-lualine/lualine.nvim'

  -- usability
  use 'kyazdani42/nvim-tree.lua'
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { "nvim-telescope/telescope-file-browser.nvim" }
  use 'MattesGroeger/vim-bookmarks'
  use 'tom-anders/telescope-vim-bookmarks.nvim'

  use 'mileszs/ack.vim'


  -- c++
  use 'neovim/nvim-lspconfig'
  use 'Kris2k/A.vim'

  -- git
  use 'tpope/vim-fugitive'
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'sindrets/diffview.nvim', requires = { 'nvim-lua/plenary.nvim' } }

  -- dap
  use 'mfussenegger/nvim-dap'
  use 'nvim-telescope/telescope-dap.nvim'

  --use 'tpope/vim-fugitive' -- Git commands in nvim
  --use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
  --use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
  --use 'ludovicchabant/vim-gutentags' -- Automatic tags management
  ---- UI to select things (files, grep results, open buffers...)
  --use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  --use 'joshdick/onedark.vim' -- Theme inspired by Atom
  ---- Add indentation guides even on blank lines
  --use 'lukas-reineke/indent-blankline.nvim'
  ---- Add git related info in the signs columns and popups
  ---- Highlight, edit, and navigate code using a fast incremental parsing library
  --use 'nvim-treesitter/nvim-treesitter'
  ---- Additional textobjects for treesitter
  --use 'nvim-treesitter/nvim-treesitter-textobjects'
  --use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  --use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  --use 'hrsh7th/cmp-nvim-lsp'
  --use 'saadparwaiz1/cmp_luasnip'
  --use 'L3MON4D3/LuaSnip' -- Snippets plugin
end)

function nmap(shortcut, command)
  vim.api.nvim_set_keymap('n', shortcut, command, { noremap = true, silent = true })
end


-- nightfox
local nightfox = require('nightfox')
local palette = require('nightfox.palette').load('nightfox')
local color = require("nightfox.lib.color")
local mybg0 = color.from_hex(palette.bg0):shade(-0.25):to_css()
local mybg1 = color.from_hex(palette.bg1):shade(-0.25):to_css()
--local diff0 = color.from_hex(palette.green.base):shade(-0.75):to_css()
--local diff1 = color.from_hex(palette.green.base):shade(-0.65):to_css()
--local diffd = color.from_hex(palette.red.base):shade(-0.8):to_css()
local diff0 = color.from_hex(palette.green.base):shade(-0.70):to_css()
local diff1 = color.from_hex(palette.green.base):shade(-0.60):to_css()
local diffd = color.from_hex(palette.red.base):shade(-0.75):to_css()
--print(vim.fn.stdpath("cache"))
nightfox.setup({
    options = {
        compile_path = vim.fn.stdpath("cache") .. "/nightfox",
        compile_file_suffix = "_compiled",
        dim_inactive = true,
    },
    specs = {
        nightfox = {
            bg0 = mybg0,
            bg1 = mybg1,

            diff = {
                add = diff0,
                change = diff0,
                delete = diffd,
                text = diff1
            },
        },
    },
    groups = {
        nightfox = {
            CursorLine = { bg = "#000000" },
            CursorColumn = { bg = "#000000" },
            DiffDelete = { fg = diff1 },
        },
    },
})
--nightfox.clean()
--nightfox.compile()
vim.cmd("colorscheme nightfox")


-- lualine

local function path_to_current_file()
  return vim.api.nvim_eval([[fnamemodify(expand("%"), ":~:.")]])
end
sections = { lualine_a = { hello } }


require('lualine').setup({
    options = {
        icons_enabled = false,
        theme = 'nord',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {},
        always_divide_middle = true,
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {path_to_current_file},
        lualine_c = {},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {path_to_current_file},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {'location'}
      },
      tabline = {},
      extensions = {}
})

-- nvim-tree
require('nvim-tree').setup({
    view = {
        centralize_selection = true,
        width = 40,
        side = "right",
        preserve_window_proportions = true,
    },
    renderer = {
        group_empty = false,
        highlight_git = false,
        full_name = false,
        highlight_opened_files = "none",
        root_folder_modifier = ":~",
        indent_markers = {
            enable = true,
            icons = {
                corner = "└  ",
                edge = "│  ",
                item = "│  ",
                none = "   ",
            },
        },
        icons = {
            webdev_colors = false,
            symlink_arrow = " ➛ ",
            show = {
                file = false,
                folder = false,
                folder_arrow = false,
                git = false,
            },
            glyphs = {
                default = "",
                symlink = "",
                folder = {
                    arrow_closed = "▸",
                    arrow_open = "▾",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
            },
        },
        special_files = { ""},
        symlink_destination = true,
    },
    hijack_directories = {
        enable = true,
        auto_open = true,
    },
    update_focused_file = {
        enable = true,
        update_root = true,
        ignore_list = {},
    },
    filters = {
        dotfiles = false,
        custom = {},
        exclude = {},
    },
    git = {
        enable = false
    },
    actions = {
        use_system_clipboard = true,
        change_dir = {
            enable = false,
            global = false,
            restrict_above_cwd = false,
        },
        open_file = {
            quit_on_open = true,
            resize_window = true,
            window_picker = {
                enable = false,
            },
        },
    },
})
nmap('<leader>fe', ':NvimTreeFindFileToggle<CR>')

-- telescope
require("telescope").setup({
  defaults = {
      layout_strategy = 'vertical',
      layout_config = {
          height = 0.9,
          width = 0.9,
      },
  },
  pickers = {
    buffers = {
      sort_mru = true,
      previewer = false,
      mappings = {
        i = {
          ["<c-d>"] = require("telescope.actions").delete_buffer,
        },
        n = {
          ["<c-d>"] = require("telescope.actions").delete_buffer,
        }
      }
    },
    find_files = {
      previewer = false,
    }
  },
  extensions = {
      file_browser = {
          layout_strategy = 'horizontal'
      }
  }
})

require("telescope").load_extension "file_browser"

nmap('<leader>fs', ':Telescope find_files<cr>')
nmap('<leader>ff', ':Telescope buffers<cr>')
nmap('<leader>fg', ':Telescope live_grep<cr>')
nmap('<leader>sw', ':Telescope grep_string<cr>')
nmap('<leader>sg', ':Telescope live_grep<cr>')
nmap('<leader>fb', ':Telescope file_browser<cr>')
nmap('<leader>va', ':Telescope git_status<cr>')

--nmap('gd', ':Telescope lsp_definitions<cr>')
--nmap('gr', ':Telescope lsp_references<cr>')
--nmap('gi', ':Telescope lsp_implementations<cr>')

-- vim-bookmarks
vim.cmd([[
  let g:bookmark_no_default_key_mappings = 1
  let g:bookmark_save_per_working_dir = 1
  let g:bookmark_auto_save = 1
]])

nmap('<leader>bb', ':BookmarkToggle<CR>')
nmap('<leader>bi', ':BookmarkAnnotate<CR>')
nmap('<leader>bn', ':BookmarkNext<CR>')
nmap('<leader>bp', ':BookmarkPrev<CR>')
nmap('<leader>ba', ':BookmarkShowAll<CR>')
nmap('<leader>bc', ':BookmarkClear<CR>')
nmap('<leader>bx', ':BookmarkClearAll<CR>')

require('telescope').load_extension('vim_bookmarks')
nmap('<leader>bl', ":Telescope vim_bookmarks all<CR>")

--local bookmark_actions = require('telescope').extensions.vim_bookmarks.actions
--require('telescope').extensions.vim_bookmarks.all {
--    attach_mappings = function(_, map) 
--        map('n', '<c-d>', bookmark_actions.delete_selected_or_at_cursor)
--        map('i', '<c-d>', bookmark_actions.delete_selected_or_at_cursor)
--        return true
--    end
--}


-- ack
vim.cmd([[
  if executable('ag')
    let g:ackprg = 'ag --vimgrep'
  endif
  nnoremap <leader>ss :AckFromSearch<CR>
  nnoremap <expr> <leader>se ':Ack! ' . @/
  
  nnoremap <expr> <leader>sc ':Ack! -G CMakeLists.txt ' . @/
]])

-- lsp
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach_lsp = function(client, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>gd', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  --buf_set_keymap('n', '<space>gn', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  --buf_set_keymap('n', '<space>gp', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  --buf_set_keymap('n', '<space>gl', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  --buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  --buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  --buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  --buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  --buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  --buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  --buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  --buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  --buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

nvim_lsp["clangd"].setup({
  filetypes = { "c", "cpp" },
  handlers = {
      ["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            update_in_insert = false,
            virtual_text = false
            }
        ),
      },
  flags = {
      debounce_text_changes = 150,
      },
  on_attach = on_attach_lsp,
  --cmd = {'clangd', '-log=verbose'},
  })

--vim.lsp.set_log_level("debug")

-- A.vim

-- let g:alternateNoDefaultAlternate=1
-- let g:alternateSearchPath = 'reg:|\([^/]*\)/src|\1/include/\1|'
-- let g:alternateSearchPath .= ',reg:|/include/\([^/]*\)|/src|'
-- 
-- " segmentation
-- let g:alternateSearchPath .= ',reg:|/src/\([^/]*\)/private|/src/\1/include/\1|'
-- let g:alternateSearchPath .= ',reg:|/include/\([^/]*\)|/private|'
-- 
-- " sjmcommon
-- let g:alternateSearchPath .= ',reg:|/src/\([^/]*\)/private|/include/\1|'
-- let g:alternateSearchPath .= ',reg:|/include/\([^/]*\)|/src/\1/private|'
-- 
-- if has("win32")
--   " stupid windows
--   let g:alternateSearchPath .= ',reg:|\\lib\\\([^/]*\)\\src|\\include\\\1|'
--   let g:alternateSearchPath .= ',reg:|\\include\\\([^/]*\)|\\lib\\\1\\src|'
-- else
--   let g:alternateSearchPath .= ',reg:|/libs/\([^/]*\)/src|/include/\1|'
--   let g:alternateSearchPath .= ',reg:|/include/\([^/]*\)|/libs/\1/src|'
-- endif

vim.cmd([[
  let g:alternateNoDefaultAlternate=1
  let g:alternateSearchPath = 'reg:|\([^/]*\)/src|\1/include/\1|'
  let g:alternateSearchPath .= ',reg:|/include/\([^/]*\)|/src|'

  let g:alternateExtensions_h   = "c,cpp,cxx,tpp,txx,cc,CC"
  let g:alternateExtensions_cpp = "hpp,h"
  let g:alternateExtensions_hpp = "cpp"
  let g:alternateExtensions_tpp = "hpp"
  let g:alternateExtensions_txx = "hxx,h"
]])

-- fugitive
nmap('<leader>vd', ':Gdiffsplit!<CR>')
nmap('<leader>vs', ':Git<CR>')

-- gitsigns
require('gitsigns').setup({
    keymaps = {}
})

-- diffview
--local cb = require'diffview.config'.diffview_callback
--require('diffview').setup({
--  diff_binaries = false,    -- Show diffs for binaries
--  enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
--  use_icons = false,        -- Requires nvim-web-devicons
--  icons = {                 -- Only applies when use_icons is true.
--    folder_closed = "",
--    folder_open = "",
--  },
--  signs = {
--    fold_closed = "▸",
--    fold_open = "▾",
--  },
--  file_panel = {
--    position = "bottom",                  -- One of 'left', 'right', 'top', 'bottom'
--    height = 16,
--    listing_style = "tree",             -- One of 'list' or 'tree'
--    tree_options = {                    -- Only applies when listing_style is 'tree'
--      flatten_dirs = true,              -- Flatten dirs that only contain one single dir
--      folder_statuses = "only_folded",  -- One of 'never', 'only_folded' or 'always'.
--    },
--  },
--  file_history_panel = {
--    position = "bottom",
--    width = 35,
--    height = 16,
--    log_options = {
--      max_count = 256,      -- Limit the number of commits
--      follow = false,       -- Follow renames (only for single file)
--      all = false,          -- Include all refs under 'refs/' including HEAD
--      merges = false,       -- List only merge commits
--      no_merges = false,    -- List no merge commits
--      reverse = false,      -- List commits in reverse order
--    },
--  },
--  default_args = {    -- Default args prepended to the arg-list for the listed commands
--    DiffviewOpen = {},
--    DiffviewFileHistory = {},
--  },
--  hooks = {},         -- See ':h diffview-config-hooks'
--  key_bindings = {
--    disable_defaults = false,                   -- Disable the default key bindings
--    -- The `view` bindings are active in the diff buffers, only when the current
--    -- tabpage is a Diffview.
--    view = {
--      ["<tab>"]      = cb("select_next_entry"),  -- Open the diff for the next file
--      ["<s-tab>"]    = cb("select_prev_entry"),  -- Open the diff for the previous file
--      ["gf"]         = cb("goto_file"),          -- Open the file in a new split in previous tabpage
--      ["<C-w><C-f>"] = cb("goto_file_split"),    -- Open the file in a new split
--      ["<C-w>gf"]    = cb("goto_file_tab"),      -- Open the file in a new tabpage
--      --["<leader>e"]  = cb("focus_files"),        -- Bring focus to the files panel
--      --["<leader>b"]  = cb("toggle_files"),       -- Toggle the files panel.
--    },
--    file_panel = {
--      ["j"]             = cb("next_entry"),           -- Bring the cursor to the next file entry
--      ["<down>"]        = cb("next_entry"),
--      ["k"]             = cb("prev_entry"),           -- Bring the cursor to the previous file entry.
--      ["<up>"]          = cb("prev_entry"),
--      ["<cr>"]          = cb("select_entry"),         -- Open the diff for the selected entry.
--      ["o"]             = cb("select_entry"),
--      ["<2-LeftMouse>"] = cb("select_entry"),
--      ["-"]             = cb("toggle_stage_entry"),   -- Stage / unstage the selected entry.
--      ["S"]             = cb("stage_all"),            -- Stage all entries.
--      ["U"]             = cb("unstage_all"),          -- Unstage all entries.
--      ["X"]             = cb("restore_entry"),        -- Restore entry to the state on the left side.
--      ["R"]             = cb("refresh_files"),        -- Update stats and entries in the file list.
--      ["<tab>"]         = cb("select_next_entry"),
--      ["<s-tab>"]       = cb("select_prev_entry"),
--      ["gf"]            = cb("goto_file"),
--      ["<C-w><C-f>"]    = cb("goto_file_split"),
--      ["<C-w>gf"]       = cb("goto_file_tab"),
--      ["i"]             = cb("listing_style"),        -- Toggle between 'list' and 'tree' views
--      ["f"]             = cb("toggle_flatten_dirs"),  -- Flatten empty subdirectories in tree listing style.
--      --["<leader>e"]     = cb("focus_files"),
--      --["<leader>b"]     = cb("toggle_files"),
--    },
--    file_history_panel = {
--      ["g!"]            = cb("options"),            -- Open the option panel
--      ["<C-A-d>"]       = cb("open_in_diffview"),   -- Open the entry under the cursor in a diffview
--      ["y"]             = cb("copy_hash"),          -- Copy the commit hash of the entry under the cursor
--      ["zR"]            = cb("open_all_folds"),
--      ["zM"]            = cb("close_all_folds"),
--      ["j"]             = cb("next_entry"),
--      ["<down>"]        = cb("next_entry"),
--      ["k"]             = cb("prev_entry"),
--      ["<up>"]          = cb("prev_entry"),
--      ["<cr>"]          = cb("select_entry"),
--      ["o"]             = cb("select_entry"),
--      ["<2-LeftMouse>"] = cb("select_entry"),
--      ["<tab>"]         = cb("select_next_entry"),
--      ["<s-tab>"]       = cb("select_prev_entry"),
--      ["gf"]            = cb("goto_file"),
--      ["<C-w><C-f>"]    = cb("goto_file_split"),
--      ["<C-w>gf"]       = cb("goto_file_tab"),
--      --["<leader>e"]     = cb("focus_files"),
--      --["<leader>b"]     = cb("toggle_files"),
--    },
--    option_panel = {
--      ["<tab>"] = cb("select"),
--      ["q"]     = cb("close"),
--    },
--  },
--})

-- nvim-dap
local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = '/home/frank/opt/bin/lldb-vscode',
  name = "lldb"
}
dap.configurations.cpp = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      --return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/../output/', 'file')
      return vim.fn.getcwd() .. '/../output/cmake_linux_x64/bin_debug/geocontroller_tests'
      
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {'--size=*', '--test=ControllerImplTest.SceneLayerAttributeBuffer'},

    -- For `runInTerminal` to true, I needed to change the yama/ptrace_scope setting
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    runInTerminal = true,
  },
}

nmap('<F5>', ":lua require'dap'.continue()<CR>")
nmap('<F10>', ":lua require'dap'.step_over()<CR>")
nmap('<F11>', ":lua require'dap'.step_into()<CR>")
nmap('<F12>', ":lua require'dap'.step_out()<CR>")
nmap('<leader>db', ":lua require'dap'.toggle_breakpoint()<CR>")
nmap('<leader>dB', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
--nmap('<leader>lp', ':lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>')
nmap('<leader>dr', ":lua require'dap'.repl.open()<CR>")

--nmap('<leader>dr', ":lua require'dap'.run_last()<CR>")
nmap('<leader>di', ":lua require'dap.ui.widgets'.hover()<CR>")

nmap('<leader>dk', ":lua require'dap'.up()<CR>")
nmap('<leader>dj', ":lua require'dap'.down()<CR>")

require("telescope").load_extension('dap')
nmap('<leader>dl', ":Telescope dap list_breakpoints<CR>")
nmap('<leader>df', ":Telescope dap frames<CR>")

nmap('<leader>d1', ":Telescope dap frames<CR>")

--vim.api.nvim_set_keymap('n', '<leader>dl', '', {
--    noremap = true,
--    callback = function()
--        require('dap').run({
--            type = ""
--        })
--    end,
--    desc = 'Debug geocontroller_tests',
--})
