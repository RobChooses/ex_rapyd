defmodule ExRapyd.Issuing.API do
  @moduledoc """
  Elixir wrapper for the Rapyd API - Issuing API
  """

  alias ExRapyd.Issuing

  @doc """
  Issue Bank Account to Wallet

  ## Example

    iex> issue_body = %ExRapyd.Issuing{country: "GB", currency: "GBP", ewallet: "ewallet_202106140546", description: "", merchant_reference_id: ""}
    iex> ExRapyd.Issuing.API.issue_bank_account(issue_body)
    {:ok, response}

  """
  def issue_bank_account(%Issuing{} = issue_body, options \\ []) do
    path = "/issuing/bankaccounts"
    body = Jason.encode!(issue_body)
    client = ExRapyd.client(%{http_method: "post", path: path, body: body}, options)
    Tesla.post(client, path, issue_body)
  end

  @doc """
  Get Bank Account History of Bank Account Number
  ## Example

    iex> ExRapyd.Issuing.API.get_bank_account_history("issuing_xxxx")
    {:ok, response}

  """
  def get_bank_account_history(bank_account_id, options \\ []) when is_binary(bank_account_id) do
    path = "/issuing/bankaccounts/#{bank_account_id}"
    client = ExRapyd.client(%{http_method: "get", path: path, body: ""}, options)
    Tesla.get(client, path)
  end

  @doc """
  Simulate a Bank Transfer to Wallet (only in sandbox)

  ## Example

    iex> issue_transfer_body = %{amount: "1000.00", currency: "GBP", issued_bank_account: "issuing_xxxx"}
    iex> ExRapyd.Issuing.API.simulate_bank_transfer(issue_transfer_body)
    {:ok, response}

  """
  def simulate_bank_transfer(issue_transfer_body, options \\ []) do
    path = "/issuing/bankaccounts/bankaccounttransfertobankaccount"
    body = Jason.encode!(issue_transfer_body)
    client = ExRapyd.client(%{http_method: "post", path: path, body: body}, options)
    Tesla.post(client, path, issue_transfer_body)
  end
end
