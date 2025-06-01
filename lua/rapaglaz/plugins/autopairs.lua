return {
  {
    "windwp/nvim-autopairs",
    enabled = true,
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true, -- Enable treesitter integration for smarter pairing
        -- fast_wrap = {}, -- Enable and configure if you want fast wrap
      })

      -- Safe integration with nvim-cmp (completion)
      local cmp_status_ok, cmp = pcall(require, "cmp")
      if cmp_status_ok then
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end
    end,
  },
}
