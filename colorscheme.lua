vim.cmd [[
try
  colorscheme nightfox
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme solarized-osaka
  set background=dark
endtry
]]
