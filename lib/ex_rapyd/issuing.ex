defmodule ExRapyd.Issuing do
  @moduledoc """
  Struct for the Rapyd API Issuing Message Body Object
  """
  use TypedStruct

  # Rapyd Issuing message bbody object
  @derive Jason.Encoder
  typedstruct do
    field :country, String.t(), enforce: true
    field :currency, String.t(), enforce: true
    field :description, String.t(), default: ""
    field :ewallet, String.t(), enforce: true
    field :merchant_reference_id, String.t(), default: ""
  end
end
  