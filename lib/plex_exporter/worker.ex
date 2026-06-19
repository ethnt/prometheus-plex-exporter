defmodule PlexExporter.Worker do
  @moduledoc """
  Polls the API to update the metrics
  """

  use GenServer

  @update_interval :timer.seconds(10)

  def start_link(_), do: GenServer.start_link(PlexExporter.Worker, %{})

  def init(state) do
    send(self(), :update)
    {:ok, state}
  end

  def handle_info(:update, state) do
    PlexExporter.Metrics.update()

    schedule_update()

    {:noreply, state}
  end

  defp schedule_update do
    Process.send_after(self(), :update, @update_interval)
  end
end
