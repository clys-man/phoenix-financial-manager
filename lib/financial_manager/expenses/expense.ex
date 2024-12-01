defmodule FinancialManager.Expenses.Expense do
  use Ecto.Schema
  import Ecto.Changeset

  schema "expenses" do
    field :date, :date
    field :description, :string
    field :amount, :decimal

    belongs_to :user, FinancialManager.Accounts.User
    belongs_to :expense_type, FinancialManager.Expenses.ExpenseType

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(expense, attrs) do
    expense
    |> cast(attrs, [:description, :date, :user_id, :expense_type_id, :amount])
    |> validate_required([:description, :date, :user_id, :expense_type_id, :amount])
    |> validate_length(:description, max: 255)
    |> validate_number(:amount, greater_than: 0)
    |> assoc_constraint(:user)
    |> assoc_constraint(:expense_type)
  end
end
