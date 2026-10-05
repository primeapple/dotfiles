return {
    'mfussenegger/nvim-jdtls',
    cond = require('toni.utils').is_workstation,
    ft = 'java',
    config = function()
        local function mise_java_home(version)
            local java_home = vim.fn.trim(vim.fn.system({
                "mise",
                "where",
                "java@" .. version,
            }))
            assert(vim.v.shell_error == 0, "mise Java " .. version .. " is not installed; run `mise install`")
            return java_home
        end

        local java_21_home = mise_java_home("temurin-21")
        local java_26_home = mise_java_home("temurin-26")

        vim.lsp.config("jdtls", {
            root_markers = { "gradlew", "settings.gradle.kts", ".git" },
            cmd_env = {
                JAVA_HOME = java_21_home,
            },
            settings = {
                java = {
                    import = {
                        gradle = {
                            wrapper = {
                                enabled = true,
                            },
                        },
                    },
                    configuration = {
                        runtimes = {
                            {
                                name = "JavaSE-21",
                                path = java_21_home,
                            },
                            {
                                name = "JavaSE-26",
                                path = java_26_home,
                            },
                        },
                    },
                },
            },
        })
        vim.lsp.enable("jdtls")
    end,
}
