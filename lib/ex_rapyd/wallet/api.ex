defmodule ExRapyd.Wallet.API do
  @moduledoc """
  Elixir wrapper for the Rapyd API - Wallet API
  """

  alias ExRapyd.Wallet

  @doc """
  Create Personal Rapyd wallet

  ## Example

    iex> wallet = %ExRapyd.Wallet{first_name: "Rob", last_name: "Chooses", ewallet_reference_id: "ewallet_202106140546", email: "", type: :person}
    iex> ExRapyd.Wallet.API.create_personal(wallet)
    {:ok, response}

  """
  def create_personal(%Wallet{} = wallet, options \\ []) do
    path = "/user"
    body = Jason.encode!(wallet)
    client = ExRapyd.client(%{http_method: "post", path: path, body: body}, options)
    Tesla.post(client, path, wallet)
  end

  def get_balance(wallet_id, options \\ []) when is_binary(wallet_id) do
    path = "/user/#{wallet_id}/accounts"
    client = ExRapyd.client(%{http_method: "get", path: path, body: ""}, options)
    Tesla.get(client, path)
  end

end