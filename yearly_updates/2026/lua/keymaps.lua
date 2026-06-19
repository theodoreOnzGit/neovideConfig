-- Custom keymaps. <leader> = Space.

-- LSP: go to definition (Space + g + d)
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition" })

-- LSP: go to references (Space + g + r)
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "Go to references" })

-- LSP: rename symbol (Space + r + n)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })

-- neo-tree: toggle the file explorer (Space + e)
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle file explorer" })

-- hop: jump to any word on screen. This overrides the built-in `f` (find char
-- on the current line), matching the old config's behaviour.
vim.keymap.set("", "f", function()
  require("hop").hint_words({ current_line_only = false })
end, { remap = true, desc = "Hop to word" })
