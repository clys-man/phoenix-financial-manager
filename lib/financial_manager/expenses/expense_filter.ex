defmodule FinancialManager.Expenses.ExpenseFilter do
  use Ecto.Schema
  import Ecto.Changeset

  @fields [:order, :start_date, :end_date]

  embedded_schema do
    field :order, :string, default: "desc"
    field :start_date, :date, default: nil
    field :end_date, :date, default: nil
  end

  @doc """
  Cria um changeset para os filtros de despesas.
  """
  def changeset(params \\ %{}) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_inclusion(:order, ["asc", "desc"], message: "Invalid order value")
    |> validate_date_range()
  end

  defp validate_date_range(changeset) do
    start_date = get_field(changeset, :start_date)
    end_date = get_field(changeset, :end_date)

    if start_date && end_date && start_date > end_date do
      add_error(changeset, :start_date, "must be earlier than end date")
    else
      changeset
    end
  end
end
