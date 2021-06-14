defmodule ExRapyd.Wallet.API do
  @moduledoc """
  Elixir wrapper for the Rapyd API - Wallet API
  """

  alias ExRapyd.Wallet

  def create_personal(%Wallet{} = wallet) do
    path = "/user"
    body = Jason.encode!(wallet)
    client = ExRapyd.client(%{http_method: "post", path: path, body: body})
    Tesla.post(client, path, wallet)
  end

end