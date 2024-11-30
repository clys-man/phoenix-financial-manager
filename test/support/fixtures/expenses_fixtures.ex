defmodule FinancialManager.ExpensesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FinancialManager.Expenses` context.
  """

  @doc """
  Generate a expense.
  """
  def expense_fixture(attrs \\ %{}) do
    {:ok, expense} =
      attrs
      |> Enum.into(%{
        amount: "120.5",
        date: ~D[2024-11-29],
        description: "some description"
      })
      |> FinancialManager.Expenses.create_expense()

    expense
  end
end
