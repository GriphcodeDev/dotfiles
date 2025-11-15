-- =====================
-- Basic Options
-- =====================
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.mouse = "a"

-- =====================
-- Install Lazy.nvim
-- =====================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- =====================
-- Plugins
-- =====================
require("lazy").setup({
  { "ellisonleao/gruvbox.nvim", priority = 1000, config = true },
  { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },
})

-- =====================
-- Theme
-- =====================
vim.o.background = "dark"
vim.cmd.colorscheme("gruvbox")

-- =====================
-- Treesitter
-- =====================
require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "python", "cpp", "javascript", "html", "css", "bash", "json", "nix", },
  highlight = { enable = true },
})

-- =====================
-- LSP setup
-- =====================
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = { "lua_ls", "pyright", "ts_ls", "bashls", "clangd", "nil_ls" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    capabilities = capabilities,
  })
end

-- =====================
-- Autocompletion
-- =====================
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }),
})

-- =====================
-- UI Enhancements
-- =====================
require("lualine").setup({
  options = { theme = "gruvbox" },
})

require("nvim-tree").setup()
