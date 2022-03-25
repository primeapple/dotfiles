local set = vim.opt
--------------------------- Invisible Characters -------------
set.list = true -- toggle invisible characters
set.listchars = {
  tab = '» ',
  extends = '›',
  precedes = '‹',
  nbsp = '·',
  trail = '·',
  space = '·',
  eol = '¬'
}
set.showbreak = '↪' -- show at the beginning of a wrapped line
