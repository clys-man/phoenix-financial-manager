defmodule FinancialManager.Expenses do
  @moduledoc """
  The Expenses context.
  """

  import Ecto.Query, warn: false
  alias FinancialManager.Repo

  alias FinancialManager.Expenses.Expense

  @doc """
  Returns the list of expenses.

  ## Examples

      iex> list_expenses()
      [%Expense{}, ...]

  """
  def list_expenses do
    Repo.all(Expense)
    |> Repo.preload(:user)
    |> Repo.preload(:expense_type)
  end

  @doc """
  Returns the list of expenses by user.

  ## Examples

      iex> list_expenses(1)
      [%Expense{}, ...]

  """
  def list_expenses(user_id) do
    Repo.all(from e in Expense, where: e.user_id == ^user_id)
    |> Repo.preload(:user)
    |> Repo.preload(:expense_type)
  end

  @doc """
  Gets a single expense.

  Raises `Ecto.NoResultsError` if the Expense does not exist.

  ## Examples

      iex> get_expense!(123)
      %Expense{}

      iex> get_expense!(456)
      ** (Ecto.NoResultsError)

  """
  def get_expense!(id),
    do: Repo.get!(Expense, id) |> Repo.preload(:user) |> Repo.preload(:expense_type)

  @doc """
  Gets a single expense by user.

  Raises `Ecto.NoResultsError` if the Expense does not exist.

  ## Examples

      iex> get_expense!(123, 1)
      %Expense{}

      iex> get_expense!(456, 1)
      ** (Ecto.NoResultsError)

  """
  def get_expense!(id, user_id),
    do:
      Repo.get_by(Expense, id: id, user_id: user_id)
      |> Repo.preload(:user)
      |> Repo.preload(:expense_type)

  @doc """
  Creates a expense.

  ## Examples

      iex> create_expense(%{field: value})
      {:ok, %Expense{}}

      iex> create_expense(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_expense(attrs \\ %{}) do
    %Expense{}
    |> Expense.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a expense.

  ## Examples

      iex> update_expense(expense, %{field: new_value})
      {:ok, %Expense{}}

      iex> update_expense(expense, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_expense(%Expense{} = expense, attrs) do
    expense
    |> Expense.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a expense.

  ## Examples

      iex> delete_expense(expense)
      {:ok, %Expense{}}

      iex> delete_expense(expense)
      {:error, %Ecto.Changeset{}}

  """
  def delete_expense(%Expense{} = expense) do
    Repo.delete(expense)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking expense changes.

  ## Examples

      iex> change_expense(expense)
      %Ecto.Changeset{data: %Expense{}}

  """
  def change_expense(%Expense{} = expense, attrs \\ %{}) do
    Expense.changeset(expense, attrs)
  end
end
