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
-- config.default_domain = 'WSL:warp'


local night = wezterm.color.get_builtin_schemes()['Aura (Gogh)']
-- night.background = 'red'

config.color_schemes = {
    ['My night'] = night
  }

config.color_scheme = 'My night'

config.font = wezterm.font('JetBrains Mono', { weight = 'Medium' } )
config.font_size = 13
-- config.color_scheme = 'Aura (Gogh)'
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = 'RESIZE'
config.window_background_opacity = 0.95
config.macos_window_background_blur = 10


-- Set the default working directory to the home directory
config.default_cwd = "~/"

-- and finally, return the configuration to wezterm
return config