local prefs =
{
    RGB      = true,
    RRGGBB   = true,
    names    = false,
    RRGGBBAA = true,
    rgb_fn   = true,
    hsl_fn   = true,
    css      = true,
    css_fn   = true,
}

require "colorizer".setup {
    lua = prefs,
    css = prefs,
    scss = prefs,
    fish = prefs,
    toml = prefs,
}
