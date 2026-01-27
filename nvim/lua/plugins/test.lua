return {
  "vim-test/vim-test",
  config = function()
    -- Set the strategy to Neovim's internal terminal
    vim.g["test#strategy"] = "neovim"
    
    -- Open the terminal in a 15-line horizontal split at the bottom
    vim.g["test#neovim#term_position"] = "belowright 15sp"
    
    -- Crucial: Don't stay in Terminal mode after the test starts
    -- This allows you to scroll/search immediately without a key combo
    vim.g["test#neovim#start_normal"] = 1

    -- Your project-specific entry points
    vim.g["test#php#pest#executable"] = "composer test"
    vim.g["test#python#pytest#executable"] = "poe test"
  end
}
