defmodule PlexExporter.Plex.Client do
  @moduledoc """
  Client for the Plex API
  """

  @type opts :: [params: map(), offset: non_neg_integer(), limit: non_neg_integer(), plug: term()]

  @doc """
  Make a GET request to the given Plex URL
  """
  @spec get(String.t(), opts()) :: {:ok, Req.Response.t()} | {:error, Exception.t()}
  def get(path, opts \\ []) do
    {params, opts} = Keyword.pop(opts, :params, %{})

    base_request(opts)
    |> Req.get(url: path, params: params)
  end

  @spec base_request(opts()) :: Req.Request.t()
  defp base_request(opts) do
    %PlexExporter.Config{url: url, token: token} = PlexExporter.config()

    Req.new(base_url: url)
    |> Req.Request.put_new_header("Accept", "application/json")
    |> Req.Request.put_new_header("X-Plex-Token", token)
    |> apply_options(opts)
  end

  @spec apply_options(Req.Request.t(), opts()) :: Req.Request.t()
  defp apply_options(request, opts) do
    request =
      case Keyword.fetch(opts, :plug) do
        {:ok, plug} -> Req.merge(request, plug: plug)
        :error -> request
      end

    with {:ok, offset} <- Keyword.fetch(opts, :offset),
         {:ok, limit} <- Keyword.fetch(opts, :limit) do
      request
      |> Req.Request.put_new_header("X-Plex-Container-Start", to_string(offset))
      |> Req.Request.put_new_header("X-Plex-Container-Size", to_string(limit))
    else
      _ -> request
    end
  end
end
