opts = function(_, opts)
	if type(opts.sources) == "table" then
		local nls = require("null-ls")
		vim.list_extend(opts.sources, {
			nls.builtins.code_actions.impl,
			nls.builtins.formatting.terraform_fmt,
			nls.builtins.diagnostics.terraform_validate,
		})
	end
end
opts = function(_, opts)
	if type(opts.ensure_installed) == "table" then
		vim.list_extend(opts.ensure_installed, { "yaml" })
		vim.list_extend(opts.ensure_installed, { "ninja", "python", "rst", "toml" })
	end
end
opts = {
	-- make sure mason installs the server
	servers = {
		yamlls = {
			-- Have to add this for yamlls to understand that we support line folding
			capabilities = {
				textDocument = {
					foldingRange = {
						dynamicRegistration = false,
						lineFoldingOnly = true,
					},
				},
			},
			-- lazy-load schemastore when needed
			on_new_config = function(new_config)
				new_config.settings.yaml.schemas = new_config.settings.yaml.schemas or {}
				vim.list_extend(new_config.settings.yaml.schemas, require("schemastore").yaml.schemas())
			end,
			settings = {
				redhat = { telemetry = { enabled = false } },
				yaml = {
					keyOrdering = false,
					format = {
						enable = true,
					},
					validate = true,
					schemaStore = {
						-- Must disable built-in schemaStore support to use
						-- schemas from SchemaStore.nvim plugin
						enable = false,
						-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
						url = "",
					},
				},
			},
		},
	},
}
