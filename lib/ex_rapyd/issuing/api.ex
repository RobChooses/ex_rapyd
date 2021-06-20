defmodule ExRapyd.Issuing.API do
  @moduledoc """
  Elixir wrapper for the Rapyd API - Issuing API
  """

  alias ExRapyd.Issuing

  @doc """
  Issue Bank Account to Wallet

  ## Example

    iex> issue_body = %ExRapyd.Issuing{country: "GB", currency: "GBP", ewallet_rapyd_id: "ewallet_202106140546", description: "", merchant_reference_id: ""}
    iex> ExRapyd.Issuing.API.issue_bank_account(issue_body)
    {:ok, response}

  """
  def issue_bank_account(%Issuing{} = issue_body, options \\ []) do
    path = "/issuing/bankaccounts"
    body = Jason.encode!(issue_body)
    client = ExRapyd.client(%{http_method: "post", path: path, body: body}, options)
    Tesla.post(client, path, issue_body)
  end
end
