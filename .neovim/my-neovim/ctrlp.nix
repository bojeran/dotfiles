{}:
''
  -- Ignore only the stuff in .gitignore
  vim.g.ctrlp_user_command = {
    types = {
      [1] = {".git", "cd %s && git ls-files -co --exclude-standard"}
    },
    fallback = "fd --type file . %s"
  }
''