defmodule FinancialManagerWeb.ExpenseTypeController do
  use FinancialManagerWeb, :controller

  alias FinancialManager.ExpenseTypes
  alias FinancialManager.Expenses.ExpenseType

  def index(conn, _params) do
    user_id = conn.assigns.current_user.id
    expense_types = ExpenseTypes.list_expense_types(user_id)
    render(conn, :index, expense_types: expense_types)
  end

  def new(conn, _params) do
    changeset = ExpenseTypes.change_expense_type(%ExpenseType{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"expense_type" => expense_type_params}) do
    expense_type_params = Map.put(expense_type_params, "user_id", conn.assigns.current_user.id)

    case ExpenseTypes.create_expense_type(expense_type_params) do
      {:ok, expense_type} ->
        conn
        |> put_flash(:info, "Expense type created successfully.")
        |> redirect(to: ~p"/expense_types/#{expense_type}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user_id = conn.assigns.current_user.id
    expense_type = ExpenseTypes.get_expense_type!(id, user_id)
    render(conn, :show, expense_type: expense_type)
  end

  def edit(conn, %{"id" => id}) do
    user_id = conn.assigns.current_user.id
    expense_type = ExpenseTypes.get_expense_type!(id, user_id)
    changeset = ExpenseTypes.change_expense_type(expense_type)
    render(conn, :edit, expense_type: expense_type, changeset: changeset)
  end

  def update(conn, %{"id" => id, "expense_type" => expense_type_params}) do
    user_id = conn.assigns.current_user.id
    expense_type = ExpenseTypes.get_expense_type!(id, user_id)
    expense_type_params = Map.put(expense_type_params, "user_id", user_id)

    case ExpenseTypes.update_expense_type(expense_type, expense_type_params) do
      {:ok, expense_type} ->
        conn
        |> put_flash(:info, "Expense type updated successfully.")
        |> redirect(to: ~p"/expense_types/#{expense_type}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, expense_type: expense_type, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_id = conn.assigns.current_user.id
    expense_type = ExpenseTypes.get_expense_type!(id, user_id)
    {:ok, _expense_type} = ExpenseTypes.delete_expense_type(expense_type)

    conn
    |> put_flash(:info, "Expense type deleted successfully.")
    |> redirect(to: ~p"/expense_types")
  end
end
