-- import gitsigns plugin safely
local setup, gitsigns = pcall(require, "gitsigns")
if not setup then
  print("gitsigns not found!")
  return
end

-- configure/enable gitsigns
gitsigns.setup()
