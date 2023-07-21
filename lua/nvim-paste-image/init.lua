print("hello from nvim-paste-image")

local function paste_image()
  print("function paste_image")
  local image_dir = "./_img"
  os.execute("mkdir -p " .. image_dir)
  math.randomseed(os.time())
  local random_number = math.random(1000, 9999)
  local date = os.date("%Y-%m-%d_%H-%M-%S")
  local image_file = image_dir .. "/" .. date .. "_" .. random_number .. ".png"
  os.execute("touch " .. image_file)
end

local function setup()
  vim.api.nvim_create_user_command("PasteImage", paste_image, { nargs = 0, desc = "Paste image" })
end

return {
  setup = setup
}
