defmodule FinancialManager.Incomes.IncomeType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "income_types" do
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(income_type, attrs) do
    income_type
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
