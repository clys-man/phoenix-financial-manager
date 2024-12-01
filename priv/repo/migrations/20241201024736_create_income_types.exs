defmodule FinancialManager.Repo.Migrations.CreateIncomeTypes do
  use Ecto.Migration

  def change do
    create table(:income_types) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end