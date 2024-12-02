defmodule FinancialManager.Incomes do
  @moduledoc """
  The Incomes context.
  """

  import Ecto.Query, warn: false
  alias FinancialManager.Incomes.IncomeFilter
  alias FinancialManager.Repo

  alias FinancialManager.Incomes.Income

  @doc """
  Returns the list of incomes.

  ## Examples

      iex> list_incomes()
      [%Income{}, ...]

  """
  def list_incomes do
    Repo.all(Income)
  end

  @doc """
  Returns the list of incomes by user.

  ## Examples

      iex> list_incomes(user_id)
      [%Income{}, ...]

  """
  def list_incomes(user_id, filter \\ %{}) do
    base_query =
      from i in Income,
        where: i.user_id == ^user_id

    filter = Map.get(filter, "income_filter", %{})
    order = Map.get(filter, "order", "desc")
    start_date = Map.get(filter, "start_date", nil)
    end_date = Map.get(filter, "end_date", nil)

    query =
      if order in ["asc", "desc"] do
        from i in base_query, order_by: [{^String.to_atom(order), i.amount}]
      else
        base_query
      end

    query =
      case {start_date, end_date} do
        {start_date, end_date}
        when start_date != "" and end_date != "" and not is_nil(start_date) and
               not is_nil(end_date) ->
          from i in query,
            where: i.date >= ^start_date and i.date <= ^end_date

        _ ->
          query
      end

    Repo.all(query)
    |> Repo.preload([:user, :income_type])
  end

  @doc """
  Gets a single income.

  Raises `Ecto.NoResultsError` if the Income does not exist.

  ## Examples

      iex> get_income!(123)
      %Income{}

      iex> get_income!(456)
      ** (Ecto.NoResultsError)

  """
  def get_income!(id), do: Repo.get!(Income, id) |> Repo.preload([:user, :inconme_type])

  @doc """
  Gets a single income.

  Raises `Ecto.NoResultsError` if the Income does not exist.

  ## Examples

      iex> get_income!(123, 1)
      %Income{}

      iex> get_income!(456, 2)
      ** (Ecto.NoResultsError)

  """
  def get_income!(id, user_id),
    do:
      Repo.get_by(Income, id: id, user_id: user_id)
      |> Repo.preload(:user)
      |> Repo.preload(:income_type)

  @doc """
  Creates a income.

  ## Examples

      iex> create_income(%{field: value})
      {:ok, %Income{}}

      iex> create_income(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_income(attrs \\ %{}) do
    %Income{}
    |> Income.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a income.

  ## Examples

      iex> update_income(income, %{field: new_value})
      {:ok, %Income{}}

      iex> update_income(income, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_income(%Income{} = income, attrs) do
    income
    |> Income.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a income.

  ## Examples

      iex> delete_income(income)
      {:ok, %Income{}}

      iex> delete_income(income)
      {:error, %Ecto.Changeset{}}

  """
  def delete_income(%Income{} = income) do
    Repo.delete(income)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking income changes.

  ## Examples

      iex> change_income(income)
      %Ecto.Changeset{data: %Income{}}

  """
  def change_income(%Income{} = income, attrs \\ %{}) do
    Income.changeset(income, attrs)
  end

  def income_filter(attrs \\ %{}) do
    IncomeFilter.changeset(attrs)
  end
end
