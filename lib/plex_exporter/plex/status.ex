defmodule PlexExporter.Plex.Status do
  @moduledoc """
  Get information about the server status, including active sessions
  """

  alias PlexExporter.Plex.Client

  @doc """
  List currently active sessions
  """
  @spec sessions(Client.opts()) :: Client.response()
  def sessions(opts \\ []) do
    Client.get("/status/sessions", opts)
  end
end
