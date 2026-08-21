return {
    'mfussenegger/nvim-jdtls',
    cond = require('toni.utils').is_workstation,
    ft = 'java',
    config = function()
        vim.lsp.config("jdtls", {
            root_markers = { "gradlew", "settings.gradle.kts", ".git" },
            -- TODO use $SDKMAN_DIR
            cmd_env = {
                JAVA_HOME = "/opt/homebrew/opt/sdkman-cli/libexec/candidates/java/21.0.12-amzn",
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
                                path = "/opt/homebrew/opt/sdkman-cli/libexec/candidates/java/21.0.12-amzn",
                            },
                            {
                                name = "JavaSE-26",
                                path = "/opt/homebrew/opt/sdkman-cli/libexec/candidates/java/26-amzn",
                            }
                        },
                    }
                }
            }
        })
        vim.lsp.enable("jdtls")
    end,
}
