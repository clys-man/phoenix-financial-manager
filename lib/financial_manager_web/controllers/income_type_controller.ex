defmodule FinancialManagerWeb.IncomeTypeController do
  use FinancialManagerWeb, :controller

  alias FinancialManager.Incomes.IncomeType
  alias FinancialManager.IncomeTypes

  def index(conn, _params) do
    user_id = conn.assigns.current_user.id
    income_types = IncomeTypes.list_income_types(user_id)
    render(conn, :index, income_types: income_types)
  end

  def new(conn, _params) do
    changeset = IncomeTypes.change_income_type(%IncomeType{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"income_type" => income_type_params}) do
    income_type_params = Map.put(income_type_params, "user_id", conn.assigns.current_user.id)

    case IncomeTypes.create_income_type(income_type_params) do
      {:ok, income_type} ->
        conn
        |> put_flash(:info, "Income type created successfully.")
        |> redirect(to: ~p"/income_types/#{income_type}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user_id = conn.assigns.current_user.id
    income_type = IncomeTypes.get_income_type!(id, user_id)
    render(conn, :show, income_type: income_type)
  end

  def edit(conn, %{"id" => id}) do
    user_id = conn.assigns.current_user.id
    income_type = IncomeTypes.get_income_type!(id, user_id)
    changeset = IncomeTypes.change_income_type(income_type)
    render(conn, :edit, income_type: income_type, changeset: changeset)
  end

  def update(conn, %{"id" => id, "income_type" => income_type_params}) do
    user_id = conn.assigns.current_user.id
    income_type = IncomeTypes.get_income_type!(id, user_id)
    income_type_params = Map.put(income_type_params, "user_id", user_id)

    case IncomeTypes.update_income_type(income_type, income_type_params) do
      {:ok, income_type} ->
        conn
        |> put_flash(:info, "Income type updated successfully.")
        |> redirect(to: ~p"/income_types/#{income_type}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, income_type: income_type, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_id = conn.assigns.current_user.id
    income_type = IncomeTypes.get_income_type!(id, user_id)
    {:ok, _income_type} = IncomeTypes.delete_income_type(income_type)

    conn
    |> put_flash(:info, "Income type deleted successfully.")
    |> redirect(to: ~p"/income_types")
  end
end
