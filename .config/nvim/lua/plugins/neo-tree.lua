return {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
        commands = {
            toggle_expand_all = function(state)
                local common = require("neo-tree.sources.common.commands")
                -- Use the filesystem command when possible so expand-all
                -- prefetches unloaded directories (common.expand_all alone
                -- only opens folders already scanned into memory).
                local expand_all = common.expand_all_nodes
                local ok, fs_commands = pcall(require, "neo-tree.sources.filesystem.commands")
                if ok and state.name == "filesystem" then
                    expand_all = fs_commands.expand_all_nodes
                end

                -- Don't infer from tree state: follow_current_file keeps paths
                -- expanded, so a detection-based toggle only ever collapses.
                if state._toggle_expand_all then
                    common.close_all_nodes(state)
                    state._toggle_expand_all = false
                else
                    expand_all(state)
                    state._toggle_expand_all = true
                end
            end,
        },
        window = {
            mappings = {
                ["z"] = "toggle_expand_all",
            },
        },
    },
}
