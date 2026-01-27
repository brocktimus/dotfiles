# Nvim

## CMP

```
<C-n>	Next Item	Standard "Next" navigation in the menu.
<C-p>	Previous Item	Standard "Previous" navigation.
<C-y>	Confirm Selection	Explicit "Yes." Safest way to avoid accidental completions.
<C-e>	Abort	Close the menu and keep exactly what you typed.
<CR>	New Line	In this config, Enter only selects if you've already highlighted an item.
<C-f>	Scroll Docs Down	If the LSP provides a documentation window, scroll it.
<C-b>	Scroll Docs Up	Scroll documentation window up.
```

## Folds

```
za	Toggle fold	Use this 90% of the time to flip between open/closed.
zc	Close fold	Explicitly hide a block.
zo	Open fold	Explicitly show a block.
zv	View cursor	If you jump to a line that's hidden, this "reveals" it.
zM	Close All	Good for getting a high-level birds-eye view of a file.
zR	Open All	The "Reset" button when folds are getting in the way.
zm	More folding	Incrementally closes the deepest nested levels.
zr	Reduce folding	Incrementally opens one level of nesting.
zj / zk	Next/Prev fold	Jump between fold boundaries without scrolling.
zx	Re-sync	Crucial: Forces Tree-sitter to recalculate broken folds.
```

More nvim:
- conform (formatting)
- autopairs?

PLUGIN VERSIONS ARE INSANE

TODO:
- Lock file for lazy-lock.json
- Gitsigns blame_line + TODO stuff
- Better LSP

If this has issues, try nix

```
vim.keymap.set('n', '<leader>tf', function()
    local file = vim.fn.expand('%')
    -- Define your command
    local cmd = file:match('%.php$') and ("vendor/bin/pest " .. file) or ("pytest " .. file)
    
    -- Open a bottom split, 15 lines high, and start the terminal
    vim.cmd("botright 15new | term " .. cmd)
    
    -- Force terminal to start in insert mode (so you can hit 'q' or 'ctrl-c' immediately)
    vim.cmd("startinsert")
end)
```
