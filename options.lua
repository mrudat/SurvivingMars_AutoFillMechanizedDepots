DefineClass("ModOptions_XDoFeOa", {
	__parents = {
		"ModOptionsObject",
	},
	properties = {
		{
			default = false,
			editor = "bool",
			id = "IgnoreUniversal",
			name = T("Ignore multi-resource depots"),
		},
		{
			default = false,
			editor = "bool",
			id = "Disable",
			name = T("Disable"),
		},
	},
})