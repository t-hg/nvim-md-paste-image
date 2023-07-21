print("hello from nvim-paste-image")

local function paste_image()
  print("function paste_image")
  local image_dir = "./_img"
  os.execute("mkdir -p " .. image_dir)
  math.randomseed(os.time())
  local random_number = math.random(1000, 9999)
  local date = os.date("%Y-%m-%d_%H-%M-%S")
  local image_file_name = date .. "_" .. random_number .. ".png"
  local image_file_path = image_dir .. "/" .. image_file_name
  os.execute("touch " .. image_file_path)
  local row, col = table.unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { "![image](" .. image_file_path .. ")" })
end

local function setup()
  vim.api.nvim_create_user_command("PasteImage", paste_image, { nargs = 0, desc = "Paste image" })
end

return {
  setup = setup
}
