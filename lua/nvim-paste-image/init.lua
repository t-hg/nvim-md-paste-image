local function paste_image()
  print("function paste_image")
end

vim.api.nvim_create_user_command(
  "PasteImage",
  paste_image,
  { nargs = 0, desc = "Paste image" }
)
