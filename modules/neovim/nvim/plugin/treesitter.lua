do
  local available_parsers = require('nvim-treesitter').get_available()

  ---@param buf integer
  ---@param language string
  ---@return boolean attached
  local function treesitter_try_attach(buf, language)
    if not vim.treesitter.language.add(language) then return false end
    vim.treesitter.start(buf, language)

    local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil
    if has_indent_query then
      vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
    return true
  end

  vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
      local buf, filetype = args.buf, args.match
      local language = vim.treesitter.language.get_lang(filetype)
      if not language then return end

      -- Not a real treesitter language (plugin UI filetypes) — ignore.
      if not vim.tbl_contains(available_parsers, language) then return end

      -- Attach directly rather than pre-checking get_installed(): that
      -- API only scans ~/.local/share/nvim/site and doesn't know about
      -- Nix-provided parsers. vim.treesitter.language.add() searches the
      -- full runtimepath itself, so it's the correct source of truth here.
      if not treesitter_try_attach(buf, language) then
        vim.notify(
          ("treesitter: no parser for '%s' — add it to nvim-treesitter.withPlugins in module.nix"):format(
            language
          ),
          vim.log.levels.WARN
        )
      end
    end,
  })
end
