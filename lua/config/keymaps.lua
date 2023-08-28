local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>ti", ":!terraform init<CR>", opts)
keymap("n", "<leader>tv", ":!terraform validate<CR>", opts)
keymap("n", "<leader>tp", ":!terraform plan<CR>", opts)
keymap("n", "<leader>taa", ":!terraform apply -auto-approve<CR>", opts)
