return {
    -- 自动补全括号
    "windwp/nvim-autopairs",
    config = function ()
        local npairs = require("nvim-autopairs")
        npairs.setup {
            check_ts = true,
            ts_config = {
                lua = { "string", "source" },
                javascript = { "string", "template_string" },
            },
            fast_wrap = {
                map = '<M-e>',
                chars = { '{', '[', '(', '"', "'" },
                pattern = [=[[%'%"%)%>%]%)%}%,]]=],
                end_key = '$',
                keys = 'qwertyuiopzxcvbnmasdfghjkl',
                check_comma = true,
                highlight = 'Search',
                highlight_grey='Comment'
            },
        }

        -- 配置这个使得自动补全会把括号带上

        local cmp_autopairs = require "nvim-autopairs.completion.cmp"
        local cmp = require("cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } }) 
    end
}
