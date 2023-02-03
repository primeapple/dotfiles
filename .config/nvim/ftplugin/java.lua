local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = '/home/toni/.cache/jdtls/' .. project_name
-- for aur version of jdtls
-- local jdtls_install_location = '/usr/share/java/jdtls/'
-- local version of jdtls
local jdtls_install_location = '/home/toni/.bin/jdtls/'

local java_debug_jar = '/home/toni/.bin/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar'
local vscode_java_test_jars_location = '/home/toni/.bin/vscode-java-test/server/'

local jdtls = require('jdtls')

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {

        -- 💀
        -- the java version to use
        '/usr/lib/jvm/java-17-openjdk/bin/java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

        -- 💀
        '-jar', vim.fn.glob(jdtls_install_location .. 'plugins/org.eclipse.equinox.launcher_*.jar'),

        -- 💀
        -- the config for the current platform
        -- this directory has to be writeable to write logs into it
        '-configuration', jdtls_install_location .. 'config_linux',

        -- 💀
        -- where the project specific data is stored
        '-data', workspace_dir,
    },

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
        java = {
            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-17",
                        path = "/usr/lib/jvm/java-17-openjdk/",
                    },
                }
            },
            contentProvider = {
                preferred = 'fernflower'
            }
        }
    },

    on_attach = function (client, buffer)
        require('toni.plugins.lsp').on_attach(client, buffer)

        jdtls.setup_dap({ hotcodereplace = 'auto' })
        jdtls.setup.add_commands()
    end
}

-- for debugging
local bundles = {
    vim.fn.glob(java_debug_jar)
};

-- for running tests
vim.list_extend(bundles, vim.split(vim.fn.glob(vscode_java_test_jars_location .. '*.jar'), '\n'))
config['init_options'] = {
  bundles = bundles;
}

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)
