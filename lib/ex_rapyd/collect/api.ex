defmodule ExRapyd.Collect.API do
  @moduledoc """
  Elixir wrapper for the Rapyd API - Collect API
  """

  alias ExRapyd.Collect.Checkout

  @doc """
  Issue Bank Account to Wallet

  ## Example

    iex> checkout_body = %ExRapyd.Collect.Checkout{
                           amount: "500",
                           cancel_checkout_url: "https://example.com/cancel_checkout",
                           complete_checkout_url: "https://example.com/complete_checkout",
                           complete_payment_url: "https://example.com/complete",
                           country: "GB",
                           currency: "GBP",
                           ewallet: "ewallet_xxxx"
                         }
    iex> ExRapyd.Collect.Checkout.create_checkout_page(checkout_body)
    {:ok, response}

  """
  def create_checkout_page(checkout_body, options \\ []) do
    path = "/checkout"
    body = Jason.encode!(checkout_body)
    client = ExRapyd.client(%{http_method: "post", path: path, body: body}, options)
    Tesla.post(client, path, checkout_body)
  end
end
