return {
  "ibhagwan/fzf-lua",
  commit = "32f3422";
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("fzf-lua").setup({
      -- Leave empty for "sane" defaults
      -- or "fzf-native" for maximum speed
    })
  end
}
