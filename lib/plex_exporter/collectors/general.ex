defmodule PlexExporter.Collectors.General do
  @moduledoc """
  Metrics about the server
  """

  alias PlexExporter.Plex

  @doc """
  Returns `:ok` if the server is up
  """
  @spec up :: {:ok, %{name: String.t()}} | {:error, atom()}
  def up do
    case Plex.General.info() do
      {:ok, %Req.Response{body: %{"MediaContainer" => %{"friendlyName" => name}}}} ->
        {:ok, %{name: name}}

      {:ok, _res} ->
        {:error, :down}

      {:error, reason} ->
        {:error, reason}
    end
  end
end
