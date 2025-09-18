local schemastore = require("schemastore")

return {
  settings = {
    yaml = {
      schemaStore = { enable = false },
      schemas = schemastore.yaml.schemas(),
    },
  },
}
