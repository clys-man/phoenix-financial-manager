defmodule FinancialManager.Expenses.ExpenseType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "expense_types" do
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(expense_type, attrs) do
    expense_type
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
