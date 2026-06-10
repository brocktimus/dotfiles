return {
  "stevearc/conform.nvim",
  opts = function()
    return {
      formatters_by_ft = {
        markdown = function(bufnr)
          local bufname = vim.api.nvim_buf_get_name(bufnr)

          -- Personal projects path check
          if string.find(bufname, "/home/brock/Vault/") then
            return { "markdownlint" }
          end

          -- Default fallback if neither match
          return { "prettier" }
        end,
        php = function(bufnr)
          local bufname = vim.api.nvim_buf_get_name(bufnr)
          return { "pint" }
        end,
      },
      -- Global settings
      foramt_on_save = nil,
      format_after_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
      notify_on_error = false, -- Keeps it quiet on PCs without the binaries
    }
  end,
}
