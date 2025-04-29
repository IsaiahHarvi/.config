local map = vim.api.nvim_set_keymap
local del_map = vim.api.nvim_del_keymap
local opts = { noremap = true, silent = true }

-- Telescope
map('n', '<leader>ff', ':Telescope find_files<CR>', opts)
map('n', '<leader>fg', ':Telescope live_grep<CR>', opts)
map('n', '<leader>fb', ':Telescope buffers<CR>', opts)
map('n', '<leader>fh', ':Telescope help_tags<CR>', opts)

-- File Explorer
map('n', '<leader>bb', ':NvimTreeToggle<CR>', opts)
map('n', '<leader>be', ':NvimTreeFocus<CR>', opts)

