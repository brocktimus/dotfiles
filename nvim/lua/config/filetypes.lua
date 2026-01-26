vim.filetype.add({
  extension = {
    jbuilder = "ruby",
    pattern = {
    -- Only treat it as JS if it's in a specific folder, for example:
    [".*/templates/.*%.tpl"] = "javascript", 
  },
  },
})
