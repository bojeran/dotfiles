{}:
''
  -- UFO setup
  require('ufo').setup({
      provider_selector = function(bufnr, filetype, buftype)
          return {'treesitter', 'indent'}
      end
  })

  vim.o.foldcolumn = '1' -- '0' is not bad
  vim.o.foldlevel = 99
  vim.o.foldlevelstart = 99
  vim.o.foldenable = true
  
  -- use default zo, zc and zO, zC
  -- overwrite these keymaps because by default when collapsing all
  -- this changes the foldlevel which is causing the whole document to collapse
  -- on <ESC> when going from Insert Mode to Normal Mode sometimes
  vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
  vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
''
