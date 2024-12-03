defmodule FinancialManagerWeb.IncomeHTML do
  use FinancialManagerWeb, :html

  embed_templates "income_html/*"

  @doc """
  Renders a income form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :income_types, :list, required: false
  attr :income, FinancialManager.Incomes.Income, required: false

  def income_form(assigns)
end
