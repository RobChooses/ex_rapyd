defmodule ExRapyd.Collect.Checkout do
  @moduledoc """
  Struct for the Rapyd API Collect Checkout Page Message Body Object
  """
  use TypedStruct

  # Rapyd Collect Checkout Page message body object
  @derive Jason.Encoder
  typedstruct do
    field :amount, String.t(), default: "0.0"
    field :cancel_checkout_url, String.t()
    field :complete_checkout_url, String.t()
    field :complete_payment_url, String.t()
    field :country, String.t(), enforce: true
    field :currency, String.t(), enforce: true
    field :ewallet, String.t()
    field :expiration, String.t()
  end
end
