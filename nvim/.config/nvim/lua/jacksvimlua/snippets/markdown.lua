local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
	-- Callouts
	s("note", {
		t("> [!NOTE]"),
		t({ "", "> " }),
		i(1, "Your note here"),
	}),

	s("tip", {
		t("> [!TIP]"),
		t({ "", "> " }),
		i(1, "Your tip here"),
	}),

	s("important", {
		t("> [!IMPORTANT]"),
		t({ "", "> " }),
		i(1, "Important information here"),
	}),

	s("warning", {
		t("> [!WARNING]"),
		t({ "", "> " }),
		i(1, "Warning message here"),
	}),

	s("caution", {
		t("> [!CAUTION]"),
		t({ "", "> " }),
		i(1, "Caution message here"),
	}),

	s("abstract", {
		t("> [!ABSTRACT]"),
		t({ "", "> " }),
		i(1, "Abstract here"),
	}),

	s("todo", {
		t("> [!TODO]"),
		t({ "", "> " }),
		i(1, "Todo item here"),
	}),

	s("subnote", {
		t("> [!SUBNOTE]"),
		t({ "", "> " }),
		i(1, "Sub-note content here"),
	}),

	-- Code blocks
	s("code", {
		t("```"),
		i(1, "language"),
		t({ "", "" }),
		i(2, "code here"),
		t({ "", "```" }),
	}),
}
