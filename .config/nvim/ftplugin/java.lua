local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = '/home/toni/.cache/jdtls/' .. project_name


local config = {
    cmd = {
        'jdtls',
        '-data',
        workspace_dir,
    },

    settings = {
        java = {
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            import = {
                gradle = {
                    enabled = true
                },
                maven = {
                    enabled = true
                },
            },
            completion = {
                enabled = true,
                importOrder = { '' }
            },
            eclipse = {
                downloadSources = true
            },
            maven = {
                downloadSources = true,
                updateSnapshotts = true
            },
            referencesCodeLens = {
                enabled = true
            },
            implementationsCodeLens = {
                enabled = false
            },
            format = {
                enabled = true,
                insertSpace = true,
                tabSize = 4,
            },
            signatureHelp = {
                enabled = true
            },
            saveActions = {
                organizeImports = false,
            },
            inlayhints = {
                parameterNames = true
            },
            jdt = {
                ls = {
                    lombokSupport = {
                        enabled = true
                    }
                }
            }
        }
    },

    init_options = {
        bundles = {}
    },
    on_attach = function(client, buffer)
        require('toni.utils').on_attach(client, buffer)
    end,
}

require('jdtls').start_or_attach(config)
