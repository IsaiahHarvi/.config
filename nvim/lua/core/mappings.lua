local map = vim.api.nvim_set_keymap
local del_map = vim.api.nvim_del_keymap
local opts = { noremap = true, silent = true }

map('n', '<leader>ff', ':Telescope find_files<CR>', opts)
map('n', '<leader>fg', ':Telescope live_grep<CR>', opts)
map('n', '<leader>fb', ':Telescope buffers<CR>', opts)
map('n', '<leader>fh', ':Telescope help_tags<CR>', opts)

