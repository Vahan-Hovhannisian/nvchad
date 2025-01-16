return {

   {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require "configs.conform"
    end,
  },
  {
    "stevearc/dressing.nvim",
    lazy = false,
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  { "nvim-neotest/nvim-nio" },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
        "eslint-lsp",
        "gopls",
        "js-debug-adapter",
        "typescript-language-server",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "typescript",
        "javascript",
        "go",
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      require "configs.lint"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "nvim-neotest/neotest",
    event = "VeryLazy",
    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-jest" {
            jestCommand = "npm test --",
            jestConfigFile = "jest.config.ts",
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          },
        },
      }
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "haydenmeade/neotest-jest",
    },
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      local ok, dap = pcall(require, "dap")
      if not ok then
        return
      end
      dap.configurations.typescript = {
        {
          type = "node2",
          name = "node attach",
          request = "attach",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
        },
      }
      dap.adapters.node2 = {
        type = "executable",
        command = "node-debug2-adapter",
        args = {},
      }
    end,
    dependencies = {
      "mxsdev/nvim-dap-vscode-js",
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    config = function()
      require("dapui").setup()

      local dap, dapui = require "dap", require "dapui"

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open {}
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close {}
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close {}
      end
    end,
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },
  {
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup {
        library = { plugins = { "nvim-dap-ui" }, types = true },
      }
    end,
  },
  { "tpope/vim-fugitive" },
  { "rbong/vim-flog", dependencies = {
    "tpope/vim-fugitive",
  }, lazy = false },
  { "sindrets/diffview.nvim", lazy = false },
  {
    "ggandor/leap.nvim",
    lazy = false,
    config = function()
      require("leap").add_default_mappings(true)
    end,
  },
  {
    "kevinhwang91/nvim-bqf",
    lazy = false,
  },
  {
    "folke/trouble.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    config = function()
      require("todo-comments").setup()
    end,
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
   {
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
          
        },update_focused_file = {
    enable = true,        -- Включаем обновление фокуса
    update_cwd = true,    -- Обновлять текущую рабочую директорию
  },
        renderer = {

          root_folder_label = false,
          icons = {
            glyphs = {
              git = {
                unstaged = "", -- Иконка для unstaged изменений (красный кружок)
                staged = "✓", -- Иконка для staged изменений (зеленая галочка)
                unmerged = "", -- Иконка для unmerged изменений (значок конфликта)
                renamed = "➜", -- Иконка для переименованных файлов
                untracked = "U", -- Иконка для untracked файлов (новые файлы)
                deleted = "", -- Иконка для удаленных файлов
                ignored = "◌", -- Иконка для игнорируемых файлов
              },
            },
            git_placement = "after",
          },
        },
        git = {
          ignore = false
        }
      })
        vim.cmd([[
highlight NvimTreeCursorLine guibg=#2F4F4F gui=none
]])
    end,
  },
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = {
  --     ensure_installed = {
  --       "vim", "lua", "vimdoc",
  --       "html", "css", "prisma",
  --     },
  --   },
  -- },
}
