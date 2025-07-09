return {
	"rareitems/anki.nvim",
	opts = {
		{
			-- this function will add support for associating '.anki' extension with both 'anki' and 'tex' filetype.
			tex_support = false,
			models = {
				-- Here you specify which notetype should be associated with which deck
				NoteType = "PathToDeck",
				["Basic"] = "Deck",
				["Super Basic"] = "Deck::ChildDeck",
			},
		},
	},
}
