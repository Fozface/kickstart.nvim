-- lua/custom/neon-aurora.lua
-- "Neon Aurora" colorscheme: ray-x/aurora purples + neon greens, blended with
-- tokyonight (structure, blues/orange), embark (soft pink, mint, cream) and
-- kukishinobu (deep violet backgrounds). Same palette as ~/.config/sway/neon-colors.conf.
--
-- Built on tokyonight.nvim's engine (it covers treesitter, LSP and plugin groups);
-- we just swap its palette and remap the main syntax groups.
-- Keywords (let, return, if) are soft purple instead of aurora's harsh red.

local p = {
  black = '#0b0816',
  dark = '#100c1e',
  bg = '#171030',
  bg2 = '#1f1736',
  bg3 = '#2c2148',
  bg4 = '#3a2c5c',
  sel = '#3d3168',

  fg = '#e0d8f4',
  text = '#cfc6e6',
  dim = '#9a92ba',
  muted = '#6f6890',
  comment = '#7a72a8',

  purple = '#bb9af7',
  violet = '#d4bfff',
  green = '#72f1b8', -- neon green
  lime = '#b8f36b', -- neon lime
  aqua = '#a1efd3', -- embark mint
  teal = '#2de2c6',
  cyan = '#7dcfff',
  blue = '#82aaff',
  sky = '#89ddff',
  yellow = '#ffe6b3', -- embark cream
  orange = '#ff9e64',
  peach = '#f2b482',
  pink = '#f48fb1', -- embark soft red
  red = '#ff6e8a',
}

vim.pack.add { 'https://github.com/folke/tokyonight.nvim' }

require('tokyonight').setup {
  style = 'night',
  styles = {
    comments = { italic = false },
    keywords = { italic = false },
  },
  on_colors = function(c)
    c.bg = p.bg
    c.bg_dark = p.dark
    c.bg_dark1 = p.black
    c.bg_float = p.bg2
    c.bg_popup = p.bg2
    c.bg_sidebar = p.dark
    c.bg_statusline = p.dark
    c.bg_highlight = p.bg2
    c.bg_visual = p.sel
    c.bg_search = p.bg4
    c.border = p.bg4
    c.border_highlight = p.purple
    c.fg = p.fg
    c.fg_dark = p.text
    c.fg_float = p.fg
    c.fg_sidebar = p.text
    c.fg_gutter = p.bg4
    c.comment = p.comment
    c.dark3 = p.muted
    c.dark5 = p.dim
    c.terminal_black = p.bg4
    c.blue = p.blue
    c.blue1 = p.cyan
    c.blue5 = p.sky
    c.cyan = p.cyan
    c.green = p.green
    c.green1 = p.aqua
    c.teal = p.teal
    c.magenta = p.purple
    c.purple = p.violet
    c.orange = p.orange
    c.yellow = p.yellow
    c.red = p.red
    c.red1 = p.pink
    c.git = { add = p.green, change = p.blue, delete = p.pink, ignore = p.muted }
  end,
  on_highlights = function(hl, _)
    local function set(groups, spec)
      for _, g in ipairs(groups) do
        hl[g] = spec
      end
    end
    -- keywords: soft purple, no red
    set({
      'Keyword', 'Statement', 'Conditional', 'Repeat', 'Exception', 'Label',
      '@keyword', '@keyword.return', '@keyword.function', '@keyword.conditional',
      '@keyword.repeat', '@keyword.exception', '@keyword.operator', '@keyword.coroutine',
      '@keyword.modifier', '@keyword.type', '@keyword.storage', 'StorageClass',
    }, { fg = p.purple })
    set({ '@keyword.import', '@keyword.directive', '@keyword.directive.define', 'PreProc', 'Include', 'Define', 'PreCondit' }, { fg = p.pink })
    set({ 'Macro', '@function.macro', '@constant.macro', '@lsp.type.macro' }, { fg = p.peach })
    -- functions: neon green
    set({ 'Function', '@function', '@function.call', '@function.method', '@function.method.call', '@lsp.type.function', '@lsp.type.method' }, { fg = p.green })
    set({ '@function.builtin', '@constructor' }, { fg = p.teal })
    -- strings: lime, escapes cream
    set({ 'String', '@string', 'Character', '@character' }, { fg = p.lime })
    set({ '@string.escape', '@string.special', 'SpecialChar', '@character.special' }, { fg = p.yellow })
    -- types: cyan / blue
    set({ 'Type', '@type', '@type.definition', 'Structure', 'Typedef', '@lsp.type.type', '@lsp.type.struct', '@lsp.type.class', '@lsp.type.enum' }, { fg = p.cyan })
    set({ '@type.builtin' }, { fg = p.blue })
    -- constants & numbers: warm
    set({ 'Number', '@number', 'Float', '@number.float', 'Boolean', '@boolean' }, { fg = p.orange })
    set({ 'Constant', '@constant', '@constant.builtin', '@lsp.type.enumMember' }, { fg = p.yellow })
    -- variables, fields, params
    set({ '@variable', 'Identifier', '@lsp.type.variable' }, { fg = p.fg })
    set({ '@variable.member', '@property', '@field', '@lsp.type.property' }, { fg = p.aqua })
    set({ '@variable.parameter', '@parameter', '@lsp.type.parameter' }, { fg = p.peach })
    set({ '@variable.builtin' }, { fg = p.pink })
    set({ '@module', '@namespace', '@lsp.type.namespace' }, { fg = p.violet })
    -- operators & punctuation
    set({ 'Operator', '@operator' }, { fg = p.sky })
    set({ '@punctuation.bracket', '@punctuation.delimiter', 'Delimiter' }, { fg = p.dim })
    -- comments
    set({ 'Comment', '@comment' }, { fg = p.comment })
    -- UI touches
    hl.CursorLineNr = { fg = p.green, bold = true }
    hl.LineNr = { fg = p.muted }
    hl.MatchParen = { fg = p.green, bg = p.bg4, bold = true }
    hl.Visual = { bg = p.sel }
    hl.Search = { fg = p.black, bg = p.yellow }
    hl.IncSearch = { fg = p.black, bg = p.green }
    hl.CurSearch = hl.IncSearch
    hl.FloatBorder = { fg = p.purple, bg = p.bg2 }
    hl.WinSeparator = { fg = p.bg4 }
    hl.DiagnosticError = { fg = p.red }
    hl.DiagnosticWarn = { fg = p.orange }
    hl.DiagnosticInfo = { fg = p.cyan }
    hl.DiagnosticHint = { fg = p.green }
  end,
}

vim.cmd.colorscheme 'tokyonight-night'
