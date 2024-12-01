defmodule FinancialManagerWeb.IncomeTypeControllerTest do
  use FinancialManagerWeb.ConnCase

  import FinancialManager.IncomeTypesFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  describe "index" do
    test "lists all income_types", %{conn: conn} do
      conn = get(conn, ~p"/income_types")
      assert html_response(conn, 200) =~ "Listing Income types"
    end
  end

  describe "new income_type" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/income_types/new")
      assert html_response(conn, 200) =~ "New Income type"
    end
  end

  describe "create income_type" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/income_types", income_type: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/income_types/#{id}"

      conn = get(conn, ~p"/income_types/#{id}")
      assert html_response(conn, 200) =~ "Income type #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/income_types", income_type: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Income type"
    end
  end

  describe "edit income_type" do
    setup [:create_income_type]

    test "renders form for editing chosen income_type", %{conn: conn, income_type: income_type} do
      conn = get(conn, ~p"/income_types/#{income_type}/edit")
      assert html_response(conn, 200) =~ "Edit Income type"
    end
  end

  describe "update income_type" do
    setup [:create_income_type]

    test "redirects when data is valid", %{conn: conn, income_type: income_type} do
      conn = put(conn, ~p"/income_types/#{income_type}", income_type: @update_attrs)
      assert redirected_to(conn) == ~p"/income_types/#{income_type}"

      conn = get(conn, ~p"/income_types/#{income_type}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, income_type: income_type} do
      conn = put(conn, ~p"/income_types/#{income_type}", income_type: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Income type"
    end
  end

  describe "delete income_type" do
    setup [:create_income_type]

    test "deletes chosen income_type", %{conn: conn, income_type: income_type} do
      conn = delete(conn, ~p"/income_types/#{income_type}")
      assert redirected_to(conn) == ~p"/income_types"

      assert_error_sent 404, fn ->
        get(conn, ~p"/income_types/#{income_type}")
      end
    end
  end

  defp create_income_type(_) do
    income_type = income_type_fixture()
    %{income_type: income_type}
  end
end
