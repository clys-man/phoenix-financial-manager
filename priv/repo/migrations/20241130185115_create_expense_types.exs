defmodule FinancialManager.Repo.Migrations.CreateExpenseTypes do
  use Ecto.Migration

  def change do
    create table(:expense_types) do
      add :name, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end
  end
end
