defmodule FinancialManager.Repo.Migrations.CreateExpenses do
  use Ecto.Migration

  def change do
    create table(:expenses) do
      add :description, :string
      add :date, :date
      add :amount, :decimal
      add :user_id, references(:users, on_delete: :nothing)
      add :expense_type_id, references(:expense_types, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:expenses, [:amount])
    create index(:expenses, [:date])
    create index(:expenses, [:expense_type_id])
    create index(:expenses, [:user_id])
  end
end
