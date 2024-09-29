return {
  -- Rust Tools for inline type hints and other utilities
  {
    "simrat39/rust-tools.nvim",
    config = function()
      require("rust-tools").setup({
        tools = {
          inlay_hints = {
            auto = true,
            only_current_line = false,
            show_parameter_hints = true,
            parameter_hints_prefix = "<- ",
            other_hints_prefix = "=> ",
            max_len_align = false,
          },
        },
        server = {
          on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<C-space>", require("rust-tools").hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>a", require("rust-tools").code_action_group.code_action_group,
              { buffer = bufnr })
            -- Signature help
            vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr })
          end,
          capabilities = require('cmp_nvim_lsp').default_capabilities(),
        },
      })
    end,
  },

  -- crates.nvim for managing Rust crates in Cargo.toml
  {
    "saecki/crates.nvim",
    dependencies = "hrsh7th/nvim-cmp",
    ft = { "rust", "toml" },
    config = function(_, opts)
      local crates = require('crates')
      crates.setup(opts)
      crates.show()
    end,
  },

  -- nvim-cmp for autocompletion
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- For LuaSnip users
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },

  -- cmp-nvim-lsp for LSP-based completion
  {
    "hrsh7th/cmp-nvim-lsp",
  },

  -- LuaSnip for snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",     -- Bridge between LuaSnip and nvim-cmp
      "rafamadriz/friendly-snippets", -- Prebuilt snippets for various languages
    },
  },
}


-- return {
--   -- Rust Tools for inline type hints and other utilities
--   {
--     "simrat39/rust-tools.nvim",
--     config = function()
--       require("rust-tools").setup({
--         tools = {
--           inlay_hints = {
--             auto = true,
--             only_current_line = false,
--             show_parameter_hints = true,
--             parameter_hints_prefix = "<- ",
--             other_hints_prefix = "=> ",
--             max_len_align = false,
--           },
--         },
--         server = {
--           on_attach = function(_, bufnr)
--             -- Hover actions
--             vim.keymap.set("n", "<C-space>", require("rust-tools").hover_actions.hover_actions, { buffer = bufnr })
--             -- Code action groups
--             vim.keymap.set("n", "<Leader>a", require("rust-tools").code_action_group.code_action_group,
--               { buffer = bufnr })
--           end,
--         },
--       })
--     end,
--   },
--
--   -- crates.nvim for managing Rust crates in Cargo.toml
--   {
--     "saecki/crates.nvim",
--     dependencies = "hrsh7th/nvim-cmp",
--     ft = { "rust", "toml" },
--     config = function(_, opts)
--       local crates = require('crates')
--       crates.setup(opts)
--       crates.show()
--     end,
--   },
--
--   -- nvim-cmp for autocompletion
--   {
--     "hrsh7th/nvim-cmp",
--     config = function()
--       local cmp = require("cmp")
--       require("luasnip.loaders.from_vscode").lazy_load()
--
--       cmp.setup({
--         snippet = {
--           expand = function(args)
--             require("luasnip").lsp_expand(args.body)
--           end,
--         },
--         window = {
--           completion = cmp.config.window.bordered(),
--           documentation = cmp.config.window.bordered(),
--         },
--         mapping = cmp.mapping.preset.insert({
--           ["<C-b>"] = cmp.mapping.scroll_docs(-4),
--           ["<C-f>"] = cmp.mapping.scroll_docs(4),
--           ["<C-Space>"] = cmp.mapping.complete(),
--           ["<C-e>"] = cmp.mapping.abort(),
--           ["<CR>"] = cmp.mapping.confirm({ select = true }),
--         }),
--         sources = cmp.config.sources({
--           { name = "nvim_lsp" },
--           { name = "luasnip" }, -- For LuaSnip users
--         }, {
--           { name = "buffer" },
--         }),
--       })
--     end,
--   },
--
--   -- cmp-nvim-lsp for LSP-based completion
--   {
--     "hrsh7th/cmp-nvim-lsp",
--   },
--
--   -- LuaSnip for snippets
--   {
--     "L3MON4D3/LuaSnip",
--     dependencies = {
--       "saadparwaiz1/cmp_luasnip",     -- Bridge between LuaSnip and nvim-cmp
--       "rafamadriz/friendly-snippets", -- Prebuilt snippets for various languages
--     },
--   },
-- }
--
--
