defmodule FinancialManager.IncomesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FinancialManager.Incomes` context.
  """

  @doc """
  Generate a income.
  """
  def income_fixture(attrs \\ %{}) do
    {:ok, income} =
      attrs
      |> Enum.into(%{
        amount: "120.5",
        date: ~D[2024-11-30],
        description: "some description"
      })
      |> FinancialManager.Incomes.create_income()

    income
  end
end
