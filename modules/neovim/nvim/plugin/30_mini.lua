-- [nfnl] plugin/30_mini.fnl
local now = Config.now
local now_if_args = Config.now_if_args
local later = Config.later
local function _1_()
  return require("mini.basics").setup({options = {basic = true}, mappings = {windows = true, move_with_alt = true}})
end
now(_1_)
local function _2_()
  local ext3_blocklist = {scm = true, txt = true, yml = true}
  local ext4_blocklist = {json = true, yaml = true}
  local function _3_(ext, _)
    return not (ext3_blocklist[ext:sub(-3)] or ext4_blocklist[ext:sub(-4)])
  end
  require("mini.icons").setup({use_file_extension = _3_})
  later(MiniIcons.mock_nvim_web_devicons)
  return later(MiniIcons.tweak_lsp_kind)
end
now(_2_)
local function _4_()
  return require("mini.notify").setup()
end
now(_4_)
local function _5_()
  return require("mini.sessions").setup()
end
now(_5_)
local function _6_()
  return require("mini.starter").setup()
end
now(_6_)
local function _7_()
  return require("mini.statusline").setup()
end
now(_7_)
local function _8_()
  return require("mini.tabline").setup()
end
now(_8_)
local function _9_()
  local process_items_opts = {kind_priority = {Text = -1, Snippet = 99}}
  local process_items
  local function _10_(items, base)
    return MiniCompletion.default_process_items(items, base, process_items_opts)
  end
  process_items = _10_
  require("mini.completion").setup({lsp_completion = {source_func = "omnifunc", process_items = process_items, auto_setup = false}})
  local on_attach
  local function _11_(ev)
    vim.bo[ev.buf]["omnifunc"] = "v:lua.MiniCompletion.completefunc_lsp"
    return nil
  end
  on_attach = _11_
  Config.new_autocmd("LspAttach", nil, on_attach, "Set 'omnifunc'")
  return vim.lsp.config("*", {capabilities = MiniCompletion.get_lsp_capabilities()})
end
now_if_args(_9_)
local function _12_()
  require("mini.files").setup({windows = {preview = true}})
  local add_marks
  local function _13_()
    MiniFiles.set_bookmark("c", vim.fn.stdpath("config"), {desc = "Config"})
    local vimpack_plugins = (vim.fn.stdpath("data") .. "/site/pack/hm/start")
    MiniFiles.set_bookmark("p", vimpack_plugins, {desc = "Plugins"})
    return MiniFiles.set_bookmark("w", vim.fn.getcwd, {desc = "Working directory"})
  end
  add_marks = _13_
  return Config.new_autocmd("User", "MiniFilesExplorerOpen", add_marks, "Add bookmarks")
end
now_if_args(_12_)
local function _14_()
  require("mini.misc").setup()
  MiniMisc.setup_auto_root()
  MiniMisc.setup_restore_cursor()
  return MiniMisc.setup_termbg_sync()
end
now_if_args(_14_)
local function _15_()
  return require("mini.extra").setup()
end
later(_15_)
local function _16_()
  local ai = require("mini.ai")
  return ai.setup({custom_textobjects = {B = MiniExtra.gen_ai_spec.buffer(), F = ai.gen_spec.treesitter({a = "@function.outer", i = "@function.inner"})}, search_method = "cover"})
end
later(_16_)
local function _17_()
  return require("mini.align").setup()
end
later(_17_)
local function _18_()
  return require("mini.animate").setup()
end
later(_18_)
local function _19_()
  return require("mini.bracketed").setup()
end
later(_19_)
local function _20_()
  return require("mini.bufremove").setup()
end
later(_20_)
local function _21_()
  local miniclue = require("mini.clue")
  return miniclue.setup({clues = {Config.leader_group_clues, miniclue.gen_clues.builtin_completion(), miniclue.gen_clues.g(), miniclue.gen_clues.marks(), miniclue.gen_clues.registers(), miniclue.gen_clues.square_brackets(), miniclue.gen_clues.windows({submode_resize = true}), miniclue.gen_clues.z()}, triggers = {{mode = {"n", "x"}, keys = "<Leader>"}, {mode = "n", keys = "\\"}, {mode = {"n", "x"}, keys = "["}, {mode = {"n", "x"}, keys = "]"}, {mode = "i", keys = "<C-x>"}, {mode = {"n", "x"}, keys = "g"}, {mode = {"n", "x"}, keys = "'"}, {mode = {"n", "x"}, keys = "`"}, {mode = {"n", "x"}, keys = "\""}, {mode = {"i", "c"}, keys = "<C-r>"}, {mode = "n", keys = "<C-w>"}, {mode = {"n", "x"}, keys = "s"}, {mode = {"n", "x"}, keys = "z"}}})
end
later(_21_)
local function _22_()
  return require("mini.cmdline").setup()
end
later(_22_)
local function _23_()
  return require("mini.comment").setup()
end
later(_23_)
local function _24_()
  return require("mini.cursorword").setup()
end
later(_24_)
local function _25_()
  return require("mini.diff").setup()
end
later(_25_)
local function _26_()
  return require("mini.git").setup()
end
later(_26_)
local function _27_()
  local hipatterns = require("mini.hipatterns")
  local hi_words = MiniExtra.gen_highlighter.words
  return hipatterns.setup({highlighters = {fixme = hi_words({"FIXME", "Fixme", "fixme"}, "MiniHipatternsFixme"), hack = hi_words({"HACK", "Hack", "hack"}, "MiniHipatternsHack"), todo = hi_words({"TODO", "Todo", "todo"}, "MiniHipatternsTodo"), note = hi_words({"NOTE", "Note", "note"}, "MiniHipatternsNote"), hex_color = hipatterns.gen_highlighter.hex_color()}})
end
later(_27_)
local function _28_()
  return require("mini.indentscope").setup()
end
later(_28_)
local function _29_()
  return require("mini.input").setup()
end
later(_29_)
local function _30_()
  return require("mini.jump").setup()
end
later(_30_)
local function _31_()
  return require("mini.jump2d").setup()
end
later(_31_)
local function _32_()
  require("mini.keymap").setup()
  MiniKeymap.map_multistep("i", "<Tab>", {"pmenu_next"})
  MiniKeymap.map_multistep("i", "<S-Tab>", {"pmenu_prev"})
  MiniKeymap.map_multistep("i", "<CR>", {"pmenu_accept", "minipairs_cr"})
  return MiniKeymap.map_multistep("i", "<BS>", {"minipairs_bs"})
end
later(_32_)
local function _33_()
  local map = require("mini.map")
  map.setup({symbols = {encode = map.gen_encode_symbols.dot("4x2")}, integrations = {map.gen_integration.builtin_search(), map.gen_integration.diff(), map.gen_integration.diagnostic()}})
  for _, key in ipairs({"n", "N", "*", "#"}) do
    local rhs = (key .. "zv" .. "<Cmd>lua MiniMap.refresh({}, { lines = false, scrollbar = false })<CR>")
    vim.keymap.set("n", key, rhs)
  end
  return nil
end
later(_33_)
local function _34_()
  return require("mini.move").setup()
end
later(_34_)
local function _35_()
  require("mini.operators").setup()
  vim.keymap.set("n", "(", "gxiagxila", {remap = true, desc = "Swap arg left"})
  return vim.keymap.set("n", ")", "gxiagxina", {remap = true, desc = "Swap arg right"})
end
later(_35_)
local function _36_()
  return require("mini.pairs").setup({modes = {command = true}})
end
later(_36_)
local function _37_()
  require("mini.pick").setup()
  local function _38_()
    local choose
    local function _39_(item)
      local decoded = vim.fn.system("cliphist decode", item)
      return vim.fn.setreg("+", decoded)
    end
    choose = _39_
    local source = {name = "Cliphist", choose = choose}
    return MiniPick.builtin.cli({command = {"cliphist", "list"}}, {source = source})
  end
  MiniPick.registry.cliphist = _38_
  return nil
end
later(_37_)
local function _40_()
  local latex_patterns = {"latex/**/*.json", "**/latex.json"}
  local lang_patterns = {tex = latex_patterns, plaintex = latex_patterns, markdown_inline = {"markdown.json"}}
  local snippets = require("mini.snippets")
  local config_path = vim.fn.stdpath("config")
  snippets.setup({snippets = {snippets.gen_loader.from_file((config_path .. "/snippets/global.json")), snippets.gen_loader.from_lang({lang_patterns = lang_patterns})}})
  return MiniSnippets.start_lsp_server()
end
later(_40_)
local function _41_()
  return require("mini.splitjoin").setup()
end
later(_41_)
local function _42_()
  return require("mini.surround").setup()
end
later(_42_)
local function _43_()
  return require("mini.trailspace").setup()
end
later(_43_)
local function _44_()
  return require("mini.visits").setup()
end
return later(_44_)
