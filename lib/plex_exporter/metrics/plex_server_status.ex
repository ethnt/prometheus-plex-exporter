defmodule PlexExporter.Metrics.PlexServer do
  @moduledoc """
  Metric for the server itself
  """

  @behaviour PlexExporter.Metrics.Metric

  use PlexExporter.Metrics.Metric

  alias PlexExporter.Collectors

  @impl true
  def init do
    Gauge.declare(
      name: :plex_server_status,
      labels: [:name],
      help: "Plex server status"
    )

    :ok
  end

  @impl true
  def update do
    case Collectors.General.up() do
      {:ok, %{name: name}} ->
        Gauge.set([name: :plex_server_status, labels: [name]], 1)

      {:error, _reason} ->
        Gauge.set([name: :plex_server_status, labels: [""]], 0)
    end
  end
end
