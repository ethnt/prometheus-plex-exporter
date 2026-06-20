import Config

config :plex_exporter, env: config_env()

import_config "#{config_env()}.exs"
