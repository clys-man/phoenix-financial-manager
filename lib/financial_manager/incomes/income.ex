defmodule FinancialManager.Incomes.Income do
  use Ecto.Schema
  import Ecto.Changeset

  schema "incomes" do
    field :date, :date
    field :description, :string
    field :amount, :decimal

    belongs_to :user, FinancialManager.Accounts.User
    belongs_to :income_type, FinancialManager.IncomeTypes.IncomeType

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(income, attrs) do
    income
    |> cast(attrs, [:description, :date, :user_id, :income_type_id, :amount])
    |> validate_required([:description, :date, :user_id, :income_type_id, :amount])
    |> validate_length(:description, max: 255)
    |> validate_number(:amount, greater_than: 0)
    |> assoc_constraint(:user)
    |> assoc_constraint(:income_type)
  end
end
