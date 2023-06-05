local present, comment = pcall(require, "Comment")
if not present then
    return
end
local comment_ft = require "Comment.ft"

comment.setup {
    opleader = {
        -- line-comment keymap
        line = "gc",
        -- block-comment keymap
        block = "gb"
    },

    -- create basic (operator-pending) and extended mappings for NORMAL + VISUAL
    mappings = {
        basic = true,

        -- extra-mappings
        -- include `gco`, `gcO`, `gcA`
        extra = true
    },

    -- LHS of toggle mapping in Normal + Visual mode
    toggler = {
        -- line-comment keymap
        -- makes sense to be related to your opleader.line
        line = "gcc",

        -- block-comment keymap
        -- make sense to be related to your opleader.block
        block = "gbc"
    },

    -- pre-hook, called before commenting the line
    -- can be used to determine the commentstring value
    pre_hook = nil,

    -- post-hook, called after commenting is done
    -- can be used to alter any formatting / newlines etc after commenting
    post_hook = nil,

    -- can be used to ignore certain lines when doing linewise motions
    -- can be string (lua regex)
    -- or function (that returns lua regex)
    ignore = nil
}
