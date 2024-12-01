defmodule FinancialManager.IncomeTypesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FinancialManager.Incomes` context.
  """

  @doc """
  Generate a income_type.
  """
  def income_type_fixture(attrs \\ %{}) do
    {:ok, income_type} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> FinancialManager.IncomeTypes.create_income_type()

    income_type
  end
end
