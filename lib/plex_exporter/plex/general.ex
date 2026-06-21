defmodule PlexExporter.Plex.General do
  @moduledoc """
  Get information about the server
  """

  alias PlexExporter.Plex.Client

  @doc """
  Get info about the server
  """
  @spec info(Client.opts()) :: Client.response()
  def info(opts \\ []) do
    Client.get("/", opts)
  end
end
