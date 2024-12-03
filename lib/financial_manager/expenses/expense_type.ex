defmodule FinancialManager.Expenses.ExpenseType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "expense_types" do
    field :name, :string

    belongs_to :user, FinancialManager.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(expense_type, attrs) do
    expense_type
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name, :user_id])
  end
end
