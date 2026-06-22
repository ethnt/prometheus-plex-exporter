defmodule PlexExporter.Plug do
  @moduledoc false

  use Prometheus.PlugExporter

  defoverridable call: 2

  def call(%{path_info: ["metrics"]} = conn, opts) do
    PlexExporter.Metrics.update(:instant)

    super(conn, opts)
  end

  def call(conn, opts), do: super(conn, opts)
end
