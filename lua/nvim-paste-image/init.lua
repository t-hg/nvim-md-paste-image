print("hello from nvim-paste-image")

local function paste_image()
  print("function paste_image")
end

local function setup()
  vim.api.nvim_create_user_command(
    "PasteImage",
    paste_image,
    { nargs = 0, desc = "Paste image" }
  )
end

return {
  setup = setup
}
