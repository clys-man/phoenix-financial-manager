defmodule FinancialManagerWeb.ExpenseTypeControllerTest do
  use FinancialManagerWeb.ConnCase

  import FinancialManager.ExpenseTypesFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  describe "index" do
    test "lists all expense_types", %{conn: conn} do
      conn = get(conn, ~p"/expense_types")
      assert html_response(conn, 200) =~ "Listing Expense types"
    end
  end

  describe "new expense_type" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/expense_types/new")
      assert html_response(conn, 200) =~ "New Expense type"
    end
  end

  describe "create expense_type" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/expense_types", expense_type: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/expense_types/#{id}"

      conn = get(conn, ~p"/expense_types/#{id}")
      assert html_response(conn, 200) =~ "Expense type #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/expense_types", expense_type: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Expense type"
    end
  end

  describe "edit expense_type" do
    setup [:create_expense_type]

    test "renders form for editing chosen expense_type", %{conn: conn, expense_type: expense_type} do
      conn = get(conn, ~p"/expense_types/#{expense_type}/edit")
      assert html_response(conn, 200) =~ "Edit Expense type"
    end
  end

  describe "update expense_type" do
    setup [:create_expense_type]

    test "redirects when data is valid", %{conn: conn, expense_type: expense_type} do
      conn = put(conn, ~p"/expense_types/#{expense_type}", expense_type: @update_attrs)
      assert redirected_to(conn) == ~p"/expense_types/#{expense_type}"

      conn = get(conn, ~p"/expense_types/#{expense_type}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, expense_type: expense_type} do
      conn = put(conn, ~p"/expense_types/#{expense_type}", expense_type: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Expense type"
    end
  end

  describe "delete expense_type" do
    setup [:create_expense_type]

    test "deletes chosen expense_type", %{conn: conn, expense_type: expense_type} do
      conn = delete(conn, ~p"/expense_types/#{expense_type}")
      assert redirected_to(conn) == ~p"/expense_types"

      assert_error_sent 404, fn ->
        get(conn, ~p"/expense_types/#{expense_type}")
      end
    end
  end

  defp create_expense_type(_) do
    expense_type = expense_type_fixture()
    %{expense_type: expense_type}
  end
end
