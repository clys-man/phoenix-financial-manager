defmodule FinancialManager.ExpenseTypes do
  @moduledoc """
  The ExpenseTypes context.
  """

  import Ecto.Query, warn: false
  alias FinancialManager.Repo

  alias FinancialManager.ExpenseTypes.ExpenseType

  @doc """
  Returns the list of expense_types.

  ## Examples

      iex> list_expense_types()
      [%ExpenseType{}, ...]

  """
  def list_expense_types do
    Repo.all(ExpenseType)
  end

  @doc """
  Gets a single expense_type.

  Raises `Ecto.NoResultsError` if the Expense type does not exist.

  ## Examples

      iex> get_expense_type!(123)
      %ExpenseType{}

      iex> get_expense_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_expense_type!(id), do: Repo.get!(ExpenseType, id)

  @doc """
  Creates a expense_type.

  ## Examples

      iex> create_expense_type(%{field: value})
      {:ok, %ExpenseType{}}

      iex> create_expense_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_expense_type(attrs \\ %{}) do
    %ExpenseType{}
    |> ExpenseType.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a expense_type.

  ## Examples

      iex> update_expense_type(expense_type, %{field: new_value})
      {:ok, %ExpenseType{}}

      iex> update_expense_type(expense_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_expense_type(%ExpenseType{} = expense_type, attrs) do
    expense_type
    |> ExpenseType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a expense_type.

  ## Examples

      iex> delete_expense_type(expense_type)
      {:ok, %ExpenseType{}}

      iex> delete_expense_type(expense_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_expense_type(%ExpenseType{} = expense_type) do
    Repo.delete(expense_type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking expense_type changes.

  ## Examples

      iex> change_expense_type(expense_type)
      %Ecto.Changeset{data: %ExpenseType{}}

  """
  def change_expense_type(%ExpenseType{} = expense_type, attrs \\ %{}) do
    ExpenseType.changeset(expense_type, attrs)
  end
end
