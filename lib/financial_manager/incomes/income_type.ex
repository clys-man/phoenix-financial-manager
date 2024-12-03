defmodule FinancialManager.Incomes.IncomeType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "income_types" do
    field :name, :string

    belongs_to :user, FinancialManager.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(income_type, attrs) do
    income_type
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name, :user_id])
  end
end
