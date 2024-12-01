defmodule FinancialManager.IncomeTypes do
  @moduledoc """
  The IncomeTypes context.
  """

  import Ecto.Query, warn: false
  alias FinancialManager.Repo

  alias FinancialManager.Incomes.IncomeType

  @doc """
  Returns the list of income_types.

  ## Examples

      iex> list_income_types()
      [%IncomeType{}, ...]

  """
  def list_income_types do
    Repo.all(IncomeType)
  end

  @doc """
  Gets a single income_type.

  Raises `Ecto.NoResultsError` if the Income type does not exist.

  ## Examples

      iex> get_income_type!(123)
      %IncomeType{}

      iex> get_income_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_income_type!(id), do: Repo.get!(IncomeType, id)

  @doc """
  Creates a income_type.

  ## Examples

      iex> create_income_type(%{field: value})
      {:ok, %IncomeType{}}

      iex> create_income_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_income_type(attrs \\ %{}) do
    %IncomeType{}
    |> IncomeType.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a income_type.

  ## Examples

      iex> update_income_type(income_type, %{field: new_value})
      {:ok, %IncomeType{}}

      iex> update_income_type(income_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_income_type(%IncomeType{} = income_type, attrs) do
    income_type
    |> IncomeType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a income_type.

  ## Examples

      iex> delete_income_type(income_type)
      {:ok, %IncomeType{}}

      iex> delete_income_type(income_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_income_type(%IncomeType{} = income_type) do
    Repo.delete(income_type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking income_type changes.

  ## Examples

      iex> change_income_type(income_type)
      %Ecto.Changeset{data: %IncomeType{}}

  """
  def change_income_type(%IncomeType{} = income_type, attrs \\ %{}) do
    IncomeType.changeset(income_type, attrs)
  end
end
