return {
  on_attach = function(_, _)
    vim.lsp.inlay_hint.enable(true)
  end,
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = true,
      },
      cargo = {
        buildScripts = { -- For build.rs
          enable = true,
        },
        loadOutDirsFromCheck = true,
      },
      procMacro = {
        enable = true,
      },
      inlayHints = {
        bindingModeHints = {
          enable = true,
        },
        chainingHints = {
          enable = true,
        },
        closureCaptureHints = {
          enable = true,
        },
      },
    },
  },
}
