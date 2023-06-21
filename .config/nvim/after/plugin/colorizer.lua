local all =
{
	RGB      = true,
	RRGGBB   = true,
	names    = true,
	RRGGBBAA = true,
	rgb_fn   = true,
	hsl_fn   = true,
	css      = true,
	css_fn   = true,
}

require "colorizer".setup {
	lua = all,
	css = all,
	scss = all,
}
