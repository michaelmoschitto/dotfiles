return {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
        commands = {
            toggle_expand_all = function(state)
                local commands = require("neo-tree.sources.common.commands")
                -- Don't infer from tree state: follow_current_file keeps paths
                -- expanded, so a detection-based toggle only ever collapses.
                if state._toggle_expand_all then
                    commands.close_all_nodes(state)
                    state._toggle_expand_all = false
                else
                    commands.expand_all_nodes(state)
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
