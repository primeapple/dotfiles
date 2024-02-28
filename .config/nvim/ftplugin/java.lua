local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = '/home/toni/.cache/jdtls/' .. project_name
local jdtls_dir = '/home/toni/.local/share/nvim/mason/packages/jdtls/'

local config = {
    -- for mason jdtls
    cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens',
        'java.base/java.util=ALL-UNNAMED',
        '--add-opens',
        'java.base/java.lang=ALL-UNNAMED',
        -- LATER check if this is still relevant
        -- rely on edge lombok because of this bug
        -- https://github.com/projectlombok/lombok/issues/3585
        '-javaagent:' .. '/home/toni/downloads/lombok-edge.jar',
        '-jar',
        vim.fn.glob(jdtls_dir .. 'plugins/org.eclipse.equinox.launcher_*.jar'),
        '-configuration',
        jdtls_dir .. 'config_linux',
        '-data',
        workspace_dir,
    },

    -- for aur jdtls
    -- cmd = {
    --     'jdtls',
    --     '-data',
    --     workspace_dir,
    --     '--jvm-arg=' .. '-javaagent:' .. lombok_path
    -- },

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
                    enabled = true,
                },
                maven = {
                    enabled = true,
                },
            },
            completion = {
                enabled = true,
                importOrder = { '' },
            },
            eclipse = {
                downloadSources = true,
            },
            maven = {
                downloadSources = true,
                updateSnapshotts = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            implementationsCodeLens = {
                enabled = false,
            },
            format = {
                enabled = true,
                insertSpace = true,
                tabSize = 4,
            },
            signatureHelp = {
                enabled = true,
            },
            saveActions = {
                organizeImports = false,
            },
            inlayhints = {
                parameterNames = true,
            },
        },
    },

    init_options = {
        bundles = {},
    },
    on_attach = function(client, buffer)
        require('toni.utils').on_attach(client, buffer)
    end,
}

require('jdtls').start_or_attach(config)
