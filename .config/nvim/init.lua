local present, impatient = pcall(require, "impatient")

if present then
   impatient.enable_profile()
end

require("options")
require("mappings")
require("autocmds")
require("plugins")
