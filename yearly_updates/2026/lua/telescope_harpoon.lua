-- Telescope + harpoon keymaps (imported from the old Arch config).
-- <leader> is Space (set in lua/plugins.lua).

-- telescope settings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '\\ff', builtin.find_files, {})
vim.keymap.set('n', '\\fb', builtin.buffers, {})
vim.keymap.set('n', '\\fh', builtin.help_tags, {})

-- harpoon settings (v1 API)
require("telescope").load_extension('harpoon')
vim.cmd([[
nnoremap <leader>b <cmd>lua require("harpoon.mark").add_file()<cr>
nnoremap <leader><Esc> <cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>
nnoremap <leader>q <cmd>Telescope harpoon marks<cr>
]])
