{}:
''
  local builtin = require("statuscol.builtin")
  require("statuscol").setup({
    segments = {
      { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
      { text = { '%s' }, click = 'v:lua.ScSa' },
      {
        text = { builtin.lnumfunc, ' ' },
        condition = { true, builtin.not_empty },
        click = 'v:lua.ScLa',
      },
      -- {
      --   text = {
      --     " ",                -- whitespace padding
      --     function(args)      -- custom line number highlight function
      --       return ((args.lnum % 2 > 0) and "%#DiffDelete#%=" or "%#DiffAdd#%=").."%l"
      --     end,
      --     " ",                -- whitespace padding
      --   },
      --   condition = {
      --     true,               -- always shown
      --     function(args)      -- shown only for the current window
      --       return args.actual_curwin == args.win
      --     end,
      --     builtin.not_empty,  -- only shown when the rest of the statuscolumn is not empty
      --   },
      -- }
    }
  })
''
