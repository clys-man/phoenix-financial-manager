defmodule FinancialManagerWeb.ExpenseController do
  use FinancialManagerWeb, :controller

  alias FinancialManager.Expenses
  alias FinancialManager.ExpenseTypes
  alias FinancialManager.Expenses.Expense

  def index(conn, _params) do
    user_id = conn.assigns.current_user.id
    expenses = Expenses.list_expenses(user_id)
    render(conn, :index, expenses: expenses)
  end

  def new(conn, _params) do
    changeset = Expenses.change_expense(%Expense{})
    expense_types = ExpenseTypes.list_expense_types() |> Enum.map(&{&1.name, &1.id})
    render(conn, :new, changeset: changeset, expense_types: expense_types)
  end

  def create(conn, %{"expense" => expense_params}) do
    expense_params = Map.put(expense_params, "user_id", conn.assigns.current_user.id)

    case Expenses.create_expense(expense_params) do
      {:ok, expense} ->
        conn
        |> put_flash(:info, "Expense created successfully.")
        |> redirect(to: ~p"/expenses/#{expense}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user_id = conn.assigns.current_user.id
    expense = Expenses.get_expense!(id, user_id)
    render(conn, :show, expense: expense)
  end

  def edit(conn, %{"id" => id}) do
    user_id = conn.assigns.current_user.id
    expense = Expenses.get_expense!(id, user_id)
    changeset = Expenses.change_expense(expense)
    expense_types = ExpenseTypes.list_expense_types() |> Enum.map(&{&1.name, &1.id})
    render(conn, :edit, expense: expense, changeset: changeset, expense_types: expense_types)
  end

  def update(conn, %{"id" => id, "expense" => expense_params}) do
    user_id = conn.assigns.current_user.id
    expense = Expenses.get_expense!(id, user_id)
    expense_params = Map.put(expense_params, "user_id", user_id)

    case Expenses.update_expense(expense, expense_params) do
      {:ok, expense} ->
        conn
        |> put_flash(:info, "Expense updated successfully.")
        |> redirect(to: ~p"/expenses/#{expense}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, expense: expense, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_id = conn.assigns.current_user.id
    expense = Expenses.get_expense!(id, user_id)
    {:ok, _expense} = Expenses.delete_expense(expense)

    conn
    |> put_flash(:info, "Expense deleted successfully.")
    |> redirect(to: ~p"/expenses")
  end
end
