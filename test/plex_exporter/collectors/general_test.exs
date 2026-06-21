defmodule PlexExporter.Collectors.GeneralTest do
  use PlexExporter.CollectorCase, async: true

  import Mimic

  alias PlexExporter.Collectors.General

  describe "up/0" do
    test "returns the friendly name" do
      expect(PlexExporter.Plex.General, :info, fn ->
        {:ok, %Req.Response{body: %{"MediaContainer" => %{"friendlyName" => "Foo Bar"}}}}
      end)

      assert {:ok, %{name: "Foo Bar"}} = General.up()
    end

    test "returns an error if the response is malformed" do
      expect(PlexExporter.Plex.General, :info, fn ->
        {:ok, %Req.Response{body: %{"foo" => "bar"}}}
      end)

      assert {:error, :down} = General.up()
    end

    test "returns an error with the reason if the request fails" do
      expect(PlexExporter.Plex.General, :info, fn ->
        {:error, :unauthorized}
      end)

      assert {:error, :unauthorized} = General.up()
    end
  end
end
