defmodule ExRapyd.Wallet do
  @moduledoc """
  Struct for the Rapyd API Wallet Object
  """
  use TypedStruct

  # Rapyd Wallet object
  @derive Jason.Encoder
  typedstruct do
    field :first_name, String.t(), default: ""
    field :last_name, String.t(), default: ""
    field :ewallet_reference_id, String.t(), enforce: true
    field :email, String.t(), default: ""
    field :phone_number, String.t(), default: ""
    field :type, atom(), default: :person
    # field :metadata, String.t(), default: "{}"
  end
end