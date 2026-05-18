local hop = require('hop')
-- local directions = require('hop.hint').HintDirection

vim.keymap.set('', 'f', function()
  hop.hint_words({ current_line_only = false })
end, {remap=true})
