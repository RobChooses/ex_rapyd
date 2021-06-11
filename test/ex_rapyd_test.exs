defmodule ExRapydTest do
  use ExUnit.Case
  doctest ExRapyd

  test "new rapyd client" do
    assert %Tesla.Client{} == ExRapyd.client
  end
end
