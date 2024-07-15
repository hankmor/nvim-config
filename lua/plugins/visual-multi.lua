return {
  "mg979/vim-visual-multi",
  event = "BufRead",
  branch = "master",
  -- makesure it works
  keys = { { "<C-Up>" }, { "<C-Down>" } },
  -- priority = 50,
  -- enabled = true,
  config = function() end,
}
