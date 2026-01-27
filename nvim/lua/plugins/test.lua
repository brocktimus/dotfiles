return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "V13Axel/neotest-pest",
    "nvim-neotest/neotest-python",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-pest")({
          pest_cmd = function() return "vendor/bin/pest" end,
        }),
        require("neotest-python")({
          runner = "pytest",
          -- Points to your virtualenv if you use one
          -- pytest_discover_instances = true, 
        }),
      },
      -- This fixes your "Snap-back" problem:
      -- Output stays in a static, searchable buffer.
      output = { open_on_run = true }, 
    })
  end,
}
