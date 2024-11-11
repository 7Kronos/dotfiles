-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- config.wsl_domains = {
--   {
--     -- The name of this specific domain.  Must be unique amonst all types
--     -- of domain in the configuration file.
--     name = 'WSL:warp',

--     -- The name of the distribution.  This identifies the WSL distribution.
--     -- It must match a valid distribution from your `wsl -l -v` output in
--     -- order for the domain to be useful.
--     distribution = 'Ubuntu',
--   },
-- }
config.default_domain = 'WSL:warp'

-- For example, changing the color scheme:
config.font = wezterm.font 'JetBrains Mono'
config.color_scheme = 'Night Owl (Gogh)'

-- Set the default working directory to the home directory
config.default_cwd = "~/"

-- and finally, return the configuration to wezterm
return config