import Config

config :plex_exporter,
  plex_url: "http://localhost:32400",
  plex_token: "token",
  client_options: [
    plug: {Req.Test, PlexExporter.Plex.Client}
  ]
