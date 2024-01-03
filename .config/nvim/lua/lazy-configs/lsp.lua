local lsp = require("lsp-zero")

lsp.preset("recommended")

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'denols',
    'lua_ls',
    'rust_analyzer',
    'marksman',
  },
  handlers = {
    lsp.default_setup,
  }
})

require('mason-lspconfig').setup_handlers({
  function(server_name)
      require("lspconfig")[server_name].setup({ on_attach = on_attach, capabilities = capabilities })
    end,

    ["rust_analyzer"] = function ()
        require("rust-tools").setup()
    end
})

-- Fix Undefined global 'vim'
lsp.configure('lua_ls', {
  single_file_support = true,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
})

lsp.configure('denols', {
  -- on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  filetypes = {
    'json',
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
  },
  single_file_support = true,
  init_options = {
    config = vim.fn.expand('$HOME/.dprint.json'),
    lint = true,
  },
})


local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_action = require('lsp-zero').cmp_action()
cmp.setup({ 
  cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    -- ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<S-Space>"] = cmp.mapping.complete(),
  })
})

-- disable completion with tab
-- this helps with copilot setup
-- cmp_mappings['<Tab>'] = nil
-- cmp_mappings['<S-Tab>'] = nil


lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  if client.name == "eslint" then
      vim.cmd.LspStop('eslint')
      return
  end

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
  vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end)

-- lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
})
