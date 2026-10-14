return {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
        window = {
            mappings = {
                ["z"] = function(state)
                    local commands = require("neo-tree.sources.common.commands")
                    local any_expanded = false
                    for _, node in ipairs(state.tree:get_nodes()) do
                        if node:is_expanded() then
                            any_expanded = true
                            break
                        end
                    end
                    if any_expanded then
                        commands.close_all_nodes(state)
                    else
                        commands.expand_all_nodes(state)
                    end
                end,
            },
        },
    },
}
