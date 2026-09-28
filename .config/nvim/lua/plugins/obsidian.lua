-- Obsidian is disabled until a personal vault path is set.
-- To enable: uncomment the return table below and set workspaces[].path.
return {}

--[[
return {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        workspaces = {
            {
                name = "notes",
                path = "~/Documents/notes", -- change to your vault path
            },
        },
        picker = { name = "fzf-lua" },
    },
    keys = {
        { "<leader>nn", "<cmd>Obsidian new<cr>", desc = "New note" },
        { "<leader>nf", "<cmd>Obsidian quick_switch<cr>", desc = "Find note" },
        { "<leader>ns", "<cmd>Obsidian search<cr>", desc = "Search notes" },
        { "<leader>nt", "<cmd>Obsidian today<cr>", desc = "Today's daily note" },
        { "<leader>nw", "<cmd>Obsidian workspace<cr>", desc = "Switch workspace" },
    },
}
--]]
