defmodule FinancialManagerWeb.ExpenseTypeHTML do
  use FinancialManagerWeb, :html

  embed_templates "expense_type_html/*"

  @doc """
  Renders a expense_type form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def expense_type_form(assigns)
end
