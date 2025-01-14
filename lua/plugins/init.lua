return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    'Exafunction/codeium.vim',
    event = 'BufEnter'
  },
  {
    "okuuva/auto-save.nvim",
    version = '^1.0.0',                       -- see https://devhints.io/semver, alternatively use '*' to use the latest tagged release
    cmd = "ASToggle",                         -- optional for lazy loading on command
    event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    opts = {
      -- your config goes here
      -- or just leave it empty :)
    },
  },
  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  }, {
  "brenton-leighton/multiple-cursors.nvim",
  version = "*", -- Use the latest tagged version
  opts = {},     -- This causes the plugin setup function to be called
  keys = {
    { "<C-j>",         "<Cmd>MultipleCursorsAddDown<CR>",          mode = { "n", "x" },      desc = "Add cursor and move down" },
    { "<C-k>",         "<Cmd>MultipleCursorsAddUp<CR>",            mode = { "n", "x" },      desc = "Add cursor and move up" },

    { "<C-Up>",        "<Cmd>MultipleCursorsAddUp<CR>",            mode = { "n", "i", "x" }, desc = "Add cursor and move up" },
    { "<C-Down>",      "<Cmd>MultipleCursorsAddDown<CR>",          mode = { "n", "i", "x" }, desc = "Add cursor and move down" },

    { "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>",   mode = { "n", "i" },      desc = "Add or remove cursor" },

    { "<Leader>a",     "<Cmd>MultipleCursorsAddMatches<CR>",       mode = { "n", "x" },      desc = "Add cursors to cword" },
    { "<Leader>A",     "<Cmd>MultipleCursorsAddMatchesV<CR>",      mode = { "n", "x" },      desc = "Add cursors to cword in previous area" },

    { "<Leader>d",     "<Cmd>MultipleCursorsAddJumpNextMatch<CR>", mode = { "n", "x" },      desc = "Add cursor and jump to next cword" },
    { "<Leader>D",     "<Cmd>MultipleCursorsJumpNextMatch<CR>",    mode = { "n", "x" },      desc = "Jump to next cword" },

    { "<Leader>l",     "<Cmd>MultipleCursorsLock<CR>",             mode = { "n", "x" },      desc = "Lock virtual cursors" },
  },
},
  {
    "matze/vim-move",
    event = { "User AstroFile", "InsertEnter" },
  },
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        sort = {
          sorter = function(nodes)
            -- Определяем порядок папок в соответствии с FSD
            local fsd_order = {
              "app",
              "pages",
              "widgets",
              "features",
              "entities",
              "shared",
            }

            -- Сортируем узлы
            table.sort(nodes, function(a, b)
              -- Проверяем, что узлы существуют
              if not a or not b then
                return false
              end

              -- Папки всегда наверху
              if a.type == "directory" and b.type ~= "directory" then
                return true
              elseif a.type ~= "directory" and b.type == "directory" then
                return false
              end

              -- Если это папка "src", она всегда наверху
              -- if a.name == "src" then
              --   return true
              -- elseif b.name == "src" then
              --   return false
              -- end

              -- Если это папки внутри "src", сортируем по FSD
              if a.absolute_path:find("src") and b.absolute_path:find("src") then
                local index_a = vim.tbl_contains(fsd_order, a.name) and vim.fn.index(fsd_order, a.name) or #fsd_order + 1
                local index_b = vim.tbl_contains(fsd_order, b.name) and vim.fn.index(fsd_order, b.name) or #fsd_order + 1

                if index_a ~= index_b then
                  return index_a < index_b
                else
                  return a.name < b.name
                end
              end

              -- Остальные файлы и папки сортируем по имени
              return a.name < b.name
            end)
          end
        },
        view = {
          width = 30,
          side = "left",
        },
        renderer = {
          icons = {
            git_placement = "after",
          },
        },
      })
    end,
  },


  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css"
      },
    },
  },
}
