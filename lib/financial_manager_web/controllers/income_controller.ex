defmodule FinancialManagerWeb.IncomeController do
  use FinancialManagerWeb, :controller

  alias FinancialManager.Incomes
  alias FinancialManager.IncomeTypes
  alias FinancialManager.Incomes.Income

  def index(conn, _params) do
    user_id = conn.assigns.current_user.id
    incomes = Incomes.list_incomes(user_id)
    render(conn, :index, incomes: incomes)
  end

  def new(conn, _params) do
    changeset = Incomes.change_income(%Income{})
    income_types = IncomeTypes.list_income_types() |> Enum.map(&{&1.name, &1.id})
    render(conn, :new, changeset: changeset, income_types: income_types)
  end

  def create(conn, %{"income" => income_params}) do
    income_params = Map.put(income_params, "user_id", conn.assigns.current_user.id)

    case Incomes.create_income(income_params) do
      {:ok, income} ->
        conn
        |> put_flash(:info, "Income created successfully.")
        |> redirect(to: ~p"/incomes/#{income}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user_id = conn.assigns.current_user.id
    income = Incomes.get_income!(id, user_id)
    render(conn, :show, income: income)
  end

  def edit(conn, %{"id" => id}) do
    user_id = conn.assigns.current_user.id
    income = Incomes.get_income!(id, user_id)
    changeset = Incomes.change_income(income)
    income_types = IncomeTypes.list_income_types() |> Enum.map(&{&1.name, &1.id})
    render(conn, :edit, income: income, changeset: changeset, income_types: income_types)
  end

  def update(conn, %{"id" => id, "income" => income_params}) do
    user_id = conn.assigns.current_user.id
    income = Incomes.get_income!(id)
    income_params = Map.put(income_params, "user_id", user_id)

    case Incomes.update_income(income, income_params) do
      {:ok, income} ->
        conn
        |> put_flash(:info, "Income updated successfully.")
        |> redirect(to: ~p"/incomes/#{income}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, income: income, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_id = conn.assigns.current_user.id
    income = Incomes.get_income!(id, user_id)
    {:ok, _income} = Incomes.delete_income(income)

    conn
    |> put_flash(:info, "Income deleted successfully.")
    |> redirect(to: ~p"/incomes")
  end
end
