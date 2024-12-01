defmodule FinancialManager.Repo.Migrations.CreateIncomes do
  use Ecto.Migration

  def change do
    create table(:incomes) do
      add :description, :string
      add :date, :date
      add :amount, :decimal
      add :user_id, references(:users, on_delete: :nothing)
      add :income_type_id, references(:income_types, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:incomes, [:user_id])
    create index(:incomes, [:income_type_id])
  end
end
