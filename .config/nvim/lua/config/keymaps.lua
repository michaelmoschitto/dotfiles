-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- ============================================================================
-- KEYMAPS
-- ============================================================================

-- Map Ctrl+C to act exactly like Escape
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("v", "<C-c>", "<Esc>", { desc = "Exit visual mode" })
vim.keymap.set("c", "<C-c>", "<C-c>", { desc = "Clear command line" })

vim.cmd("iabbrev todo TODO(moschitto):")
vim.cmd("iabbrev note NOTE(moschitto):")
vim.cmd("iabbrev perf PERF(moschitto):")
vim.cmd("iabbrev fixme FIXME(moschitto):")
vim.cmd("iabbrev hack HACK(moschitto):")
vim.cmd("iabbrev safety SAFETY(moschitto):")
vim.cmd("iabbrev invariant INVARIANT(moschitto):")

-- better movement in wrapped text
vim.keymap.set("n", "j", function()
    return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true, desc = "Down (wrap-aware)" })
vim.keymap.set("n", "k", function()
    return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true, desc = "Up (wrap-aware)" })

vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear search highlights" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })
vim.keymap.set({ "n", "v" }, "<leader>x", '"_d', { desc = "Delete without yanking" })

vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })

-- Option+Left/Right word navigation (works when the terminal sends Alt+arrows;
-- in iTerm, enable "Option as Meta" or Esc+ as needed).
vim.keymap.set({ "n", "x" }, "<A-Left>", "b", { desc = "Previous word" })
vim.keymap.set({ "n", "x" }, "<A-Right>", "w", { desc = "Next word" })
vim.keymap.set({ "i", "c" }, "<A-Left>", "<C-Left>", { desc = "Previous word" })
vim.keymap.set({ "i", "c" }, "<A-Right>", "<C-Right>", { desc = "Next word" })

vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })

-- LazyVim provides Ctrl+hjkl for split navigation and Ctrl+arrows for resize.
-- Keep line movement on leader mappings so those window bindings remain intact.
vim.keymap.set("n", "<leader>mj", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<leader>mk", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<leader>mj", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<leader>mk", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

vim.keymap.set("n", "<leader>pa", function() -- show file path
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    print("file:", path)
end, { desc = "Copy full file path" })

vim.keymap.set("n", "<leader>td", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })

-- ============================================================================
-- PLUGIN CONFIGS
-- ============================================================================

local setup_treesitter = function()
    local treesitter = require("nvim-treesitter")
    treesitter.setup({})
    local ensure_installed = {
        "vim",
        "vimdoc",
        "rust",
        "c",
        "cpp",
        "go",
        "html",
        "css",
        "javascript",
        "json",
        "lua",
        "markdown",
        "python",
        "typescript",
        "vue",
        "svelte",
        "bash",
    }

    local config = require("nvim-treesitter.config")

    local already_installed = config.get_installed()
    local parsers_to_install = {}

    for _, parser in ipairs(ensure_installed) do
        if not vim.tbl_contains(already_installed, parser) then
            table.insert(parsers_to_install, parser)
        end
    end

    if #parsers_to_install > 0 then
        treesitter.install(parsers_to_install)
    end

    local group = vim.api.nvim_create_augroup("TreeSitterConfig", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
        group = group,
        callback = function(args)
            if vim.list_contains(config.get_installed(), vim.treesitter.language.get_lang(args.match)) then
                vim.treesitter.start(args.buf)
            end
        end,
    })
end

setup_treesitter()
