defmodule ExRaypd.Resource.Country do
  @moduledoc """
  Elixir wrapper for the Rapyd API - Resource Methods - Country API
  """

  @doc """
  List countries

  ## Example

    iex> ExRapyd.Resource.Country.List()
    {:ok, response}

  """
  def list() do
    path = "/data/countries"
    client = ExRapyd.client(%{http_method: "get", path: path, body: ""})
    Tesla.get(client, path)
  end
end