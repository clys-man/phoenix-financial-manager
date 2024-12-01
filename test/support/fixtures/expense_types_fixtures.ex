defmodule FinancialManager.ExpenseTypesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FinancialManager.ExpenseTypes` context.
  """

  @doc """
  Generate a expense_type.
  """
  def expense_type_fixture(attrs \\ %{}) do
    {:ok, expense_type} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> FinancialManager.Expenses.create_expense_type()

    expense_type
  end
end
