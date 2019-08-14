return PlaceObj('ModDef', {
	'title', "Auto fill mechanized depots",
	'description', "Watches all storage depots, if any storage depot is over 95% full, it sets all mechanized storage depots that accept that resource to demand to be filled with minimum priority.\n\nWhen no storage depot is over 90% full, it sets all mecahnized depots to desire no resources and medium priority.\n\nHas an option to disable automatic action and to ignore depots with multiple resources.\n\nPermission is granted to update this mod to support the latest version of the game if I'm not around to do it myself.",
	'last_changes', "reduced log spam",
	'id', "XDoFeOa",
	'steam_id', "1813375694",
	'pops_desktop_uuid', "62d8d362-1883-4422-823c-7a51d42bbae5",
	'pops_any_uuid', "d8b3d457-e29c-41f0-864d-e6edc33c81ab",
	'author', "mrudat",
	'version', 18,
	'lua_revision', 233360,
	'saved_with_revision', 245618,
	'code', {
		"Code/AutoFillMechanizedDepots.lua",
	},
	'has_options', true,
	'saved', 1565002856,
})