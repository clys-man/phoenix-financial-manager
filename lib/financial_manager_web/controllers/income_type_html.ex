defmodule FinancialManagerWeb.IncomeTypeHTML do
  use FinancialManagerWeb, :html

  embed_templates "income_type_html/*"

  @doc """
  Renders a income_type form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def income_type_form(assigns)
end
