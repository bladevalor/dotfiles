local snip = require("luasnip").get_snip_env()

local get_visual = function(_, parent)
	if #parent.snippet.env.LS_SELECT_RAW > 0 then
		return snip.sn(nil, snip.i(1, parent.snippet.env.LS_SELECT_RAW))
	else
		return snip.sn(nil, snip.i(1))
	end
end

return {
	snip.s({ trig = ";a", desc = "alpha", docstring = "\\alpha" }, {
		snip.t("\\alpha"),
	}),
	snip.s(";b", { snip.t("\\beta") }),
	snip.s(";g", { snip.t("\\gamma") }),

	snip.s({ trig = "tt", snippetType = "autosnippet" }, snip.fmta("\\textt{<>}", { snip.i(1) })),
	snip.s(
		{ trig = "ff", docsting = "\\frac{}{}", snippetType = "autosnippet" },
		snip.fmta("\\frac{<>}{<>}", { snip.i(1, "numerator"), snip.i(2, "denominator") })
	),
	snip.s(
		{ trig = "eq" },
		snip.fmta(
			[[
            \begin{equation}
               <>
            \end{equation}
         ]],
			{ snip.i(1) }
		)
	),
	snip.s(
		{ trig = "env" },
		snip.fmta(
			[[
            \begin{<>}
               <>
            \end{<>}
         ]],
			{ snip.i(1), snip.i(2), snip.rep(1) }
		)
	),
	snip.s(
		{ trig = "tii", desc = "italisize the selected text" },
		snip.fmta("\\textit{<>}", { snip.d(1, get_visual) })
	),
	snip.s(
		"trig",
		snip.fmta(
			[[
            text: <>

            copy: <>
         ]],
			{ snip.i(1), snip.d(2, function(args)
				return snip.sn(nil, { snip.i(1, args[1]) })
			end, { 1 }) }
		)
	),
}
