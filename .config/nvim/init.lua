-- =====================
-- Leader (before lazy)
-- =====================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- =====================
-- Options
-- =====================
local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.termguicolors = true
opt.clipboard = "unnamedplus"
opt.splitright = true
opt.splitbelow = true
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.wrap = false
opt.undofile = true
opt.cursorline = true
opt.hlsearch = false
opt.incsearch = true
opt.updatetime = 50
opt.timeoutlen = 300

-- =====================
-- Install Lazy.nvim
-- =====================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- =====================
-- Plugins
-- =====================
require("lazy").setup({
  { "ellisonleao/gruvbox.nvim", priority = 1000 },

  { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },

  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
  },

  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },

  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "L3MON4D3/LuaSnip", dependencies = { "rafamadriz/friendly-snippets" } },
  { "saadparwaiz1/cmp_luasnip" },

  { "stevearc/conform.nvim" },
  { "lewis6991/gitsigns.nvim" },
  { "windwp/nvim-autopairs", event = "InsertEnter" },
  { "numToStr/Comment.nvim" },
  { "folke/which-key.nvim", event = "VeryLazy" },
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
  ensure_installed = {
    "lua", "python", "cpp", "c", "javascript", "typescript",
    "html", "css", "bash", "json", "nix", "go", "rust", "toml", "yaml",
  },
  highlight = { enable = true },
  indent = { enable = true },
})

-- =====================
-- Telescope
-- =====================
local telescope = require("telescope")
telescope.setup({
  defaults = {
    file_ignore_patterns = { "%.git/", "node_modules/" },
  },
})
telescope.load_extension("fzf")

-- =====================
-- LSP
-- =====================
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls", "pyright", "ts_ls", "bashls", "clangd", "gopls",
  },
  automatic_installation = true,
})

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(_, bufnr)
  local map = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
  end
  map("gd", vim.lsp.buf.definition, "Go to Definition")
  map("gD", vim.lsp.buf.declaration, "Go to Declaration")
  map("gr", vim.lsp.buf.references, "Go to References")
  map("gi", vim.lsp.buf.implementation, "Go to Implementation")
  map("K", vim.lsp.buf.hover, "Hover Docs")
  map("<leader>rn", vim.lsp.buf.rename, "Rename")
  map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
  map("<leader>d", vim.diagnostic.open_float, "Show Diagnostics")
  map("[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
  map("]d", vim.diagnostic.goto_next, "Next Diagnostic")
end

local servers = { "pyright", "ts_ls", "bashls", "clangd", "gopls" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({ capabilities = capabilities, on_attach = on_attach })
end

lspconfig.lua_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = { checkThirdParty = false },
    },
  },
})

-- =====================
-- Autocompletion
-- =====================
local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
      else fallback() end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then luasnip.jump(-1)
      else fallback() end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }),
})

-- =====================
-- Conform (formatting)
-- =====================
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    html = { "prettier" },
    css = { "prettier" },
    json = { "prettier" },
    go = { "gofmt" },
    rust = { "rustfmt" },
    sh = { "shfmt" },
  },
  format_on_save = { timeout_ms = 500, lsp_fallback = true },
})

-- =====================
-- Gitsigns
-- =====================
require("gitsigns").setup({
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    local map = function(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { buffer = bufnr, desc = "Git: " .. desc })
    end
    map("n", "]c", gs.next_hunk, "Next Hunk")
    map("n", "[c", gs.prev_hunk, "Prev Hunk")
    map("n", "<leader>gs", gs.stage_hunk, "Stage Hunk")
    map("n", "<leader>gr", gs.reset_hunk, "Reset Hunk")
    map("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
    map("n", "<leader>gb", gs.blame_line, "Blame Line")
  end,
})

-- =====================
-- Autopairs
-- =====================
require("nvim-autopairs").setup()
cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())

-- =====================
-- Comment
-- =====================
require("Comment").setup()

-- =====================
-- Which-key
-- =====================
require("which-key").setup()

-- =====================
-- Lualine
-- =====================
require("lualine").setup({ options = { theme = "gruvbox" } })

-- =====================
-- Nvim-tree
-- =====================
require("nvim-tree").setup({
  view = { width = 30 },
  renderer = { group_empty = true },
  filters = { dotfiles = false },
})

-- =====================
-- Keymaps
-- =====================
local map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

-- File tree
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", "Toggle File Tree")

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", "Find Files")
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", "Live Grep")
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", "Buffers")
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", "Recent Files")
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", "Help")

-- Window navigation
map("n", "<C-h>", "<C-w>h", "Left Window")
map("n", "<C-j>", "<C-w>j", "Lower Window")
map("n", "<C-k>", "<C-w>k", "Upper Window")
map("n", "<C-l>", "<C-w>l", "Right Window")

-- Buffer navigation
map("n", "<S-l>", "<cmd>bnext<CR>", "Next Buffer")
map("n", "<S-h>", "<cmd>bprevious<CR>", "Prev Buffer")
map("n", "<leader>bd", "<cmd>bdelete<CR>", "Delete Buffer")

-- Move selected lines
map("v", "J", ":m '>+1<CR>gv=gv", "Move Line Down")
map("v", "K", ":m '<-2<CR>gv=gv", "Move Line Up")

-- Stay in indent mode
map("v", "<", "<gv", "Dedent")
map("v", ">", ">gv", "Indent")

-- Centered scrolling
map("n", "<C-d>", "<C-d>zz", "Scroll Down")
map("n", "<C-u>", "<C-u>zz", "Scroll Up")
map("n", "n", "nzzzv", "Next Result")
map("n", "N", "Nzzzv", "Prev Result")

-- Save / quit
map("n", "<leader>w", "<cmd>w<CR>", "Save")
map("n", "<leader>q", "<cmd>q<CR>", "Quit")

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", "Clear Search")

-- Format
map("n", "<leader>fm", function() require("conform").format({ async = true }) end, "Format File")
