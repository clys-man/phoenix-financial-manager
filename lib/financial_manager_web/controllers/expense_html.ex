defmodule FinancialManagerWeb.ExpenseHTML do
  use FinancialManagerWeb, :html

  embed_templates "expense_html/*"

  @doc """
  Renders a expense form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :expense_types, :string, required: true
  attr :expense, FinancialManager.Expenses.Expense, required: false

  def expense_form(assigns)
end
