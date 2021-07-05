defmodule ExRapyd.Wallet.API do
  @moduledoc """
  Elixir wrapper for the Rapyd API - Wallet API
  """

  @doc """
  Create Personal Rapyd wallet

  ## Example

    iex> wallet = %ExRapyd.Wallet{first_name: "Rob", last_name: "Chooses", ewallet_reference_id: "ewallet_202106140546", email: "", type: :person}
    iex> ExRapyd.Wallet.API.create_personal(wallet)
    {:ok, response}

  """
  def create_personal(wallet, options \\ []) do
    path = "/user"
    body = Jason.encode!(wallet)
    client = ExRapyd.client(%{http_method: "post", path: path, body: body}, options)
    Tesla.post(client, path, wallet)
  end

  @doc """
  Get balance(s) of a Rapyd wallet id

  ## Example

    iex> ExRapyd.Wallet.API.get_balance("ewallet_202106140546")
    {:ok, response}

  """
  def get_balance(wallet_id, options \\ []) when is_binary(wallet_id) do
    path = "/user/#{wallet_id}/accounts"
    client = ExRapyd.client(%{http_method: "get", path: path, body: ""}, options)
    Tesla.get(client, path)
  end

  @doc """
  Get transactions of a Rapyd wallet id

  ## Example

    iex> ExRapyd.Wallet.API.get_transactions("ewallet_202106140546")
    {:ok, response}

  """
  def get_transactions(wallet_id, options \\ []) when is_binary(wallet_id) do
    path = "/user/#{wallet_id}/transactions"
    client = ExRapyd.client(%{http_method: "get", path: path, body: ""}, options)
    Tesla.get(client, path)
  end

  @doc """
  Get details of a Rapyd wallet transaction id

  ## Example

    iex> ExRapyd.Wallet.API.get_transaction_detail("ewallet_202106140546", "wt_202106140547")
    {:ok, response}

  """
  def get_transaction_detail(wallet_id, transaction_id, options \\ []) when is_binary(wallet_id) and is_binary(transaction_id) do
    path = "/user/#{wallet_id}/transactions/#{transaction_id}"
    client = ExRapyd.client(%{http_method: "get", path: path, body: ""}, options)
    Tesla.get(client, path)
  end

  @doc """
  Transfer funds between Rapyd wallets

  ## Example

    iex> transfer_funds_body = %{amount: "100", currency: "USD", destination_ewallet: "ewallet_202106140546",
                                 source_ewallet: "ewallet_202106140500"}
    iex> ExRapyd.Wallet.API.transfer_funds(transfer_funds_body)
    {:ok, response}

  """
  def transfer_funds(transfer_funds_body, options \\ []) do
    path = "/account/transfer"
    body = Jason.encode!(transfer_funds_body)
    client = ExRapyd.client(%{http_method: "post", path: path, body: body}, options)
    Tesla.post(client, path, transfer_funds_body)
  end

  @doc """
  Set Transfer Response for Transfer Funds request between Rapyd wallets

  ## Example

    iex> set_transfer_response_body = %{id: "5baf0079-dd49-11eb-b38b-02240218ee6d", status: "accept"}
    iex> ExRapyd.Wallet.API.set_transfer_response(set_transfer_response_body)
    {:ok, response}

  """
  def set_transfer_response(set_transfer_response_body, options \\ []) do
    path = "/account/transfer/response"
    body = Jason.encode!(set_transfer_response_body)
    client = ExRapyd.client(%{http_method: "post", path: path, body: body}, options)
    Tesla.post(client, path, set_transfer_response_body)
  end



end
