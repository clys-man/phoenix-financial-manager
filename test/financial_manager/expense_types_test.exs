defmodule FinancialManager.ExpenseTypesTest do
  use FinancialManager.DataCase

  alias FinancialManager.ExpenseTypes

  describe "expense_types" do
    alias FinancialManager.ExpenseTypes.ExpenseType

    import FinancialManager.ExpenseTypesFixtures

    @invalid_attrs %{name: nil}

    test "list_expense_types/0 returns all expense_types" do
      expense_type = expense_type_fixture()
      assert ExpenseTypes.list_expense_types() == [expense_type]
    end

    test "get_expense_type!/1 returns the expense_type with given id" do
      expense_type = expense_type_fixture()
      assert ExpenseTypes.get_expense_type!(expense_type.id) == expense_type
    end

    test "create_expense_type/1 with valid data creates a expense_type" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %ExpenseType{} = expense_type} = ExpenseTypes.create_expense_type(valid_attrs)
      assert expense_type.name == "some name"
    end

    test "create_expense_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ExpenseTypes.create_expense_type(@invalid_attrs)
    end

    test "update_expense_type/2 with valid data updates the expense_type" do
      expense_type = expense_type_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %ExpenseType{} = expense_type} = ExpenseTypes.update_expense_type(expense_type, update_attrs)
      assert expense_type.name == "some updated name"
    end

    test "update_expense_type/2 with invalid data returns error changeset" do
      expense_type = expense_type_fixture()
      assert {:error, %Ecto.Changeset{}} = ExpenseTypes.update_expense_type(expense_type, @invalid_attrs)
      assert expense_type == ExpenseTypes.get_expense_type!(expense_type.id)
    end

    test "delete_expense_type/1 deletes the expense_type" do
      expense_type = expense_type_fixture()
      assert {:ok, %ExpenseType{}} = ExpenseTypes.delete_expense_type(expense_type)
      assert_raise Ecto.NoResultsError, fn -> ExpenseTypes.get_expense_type!(expense_type.id) end
    end

    test "change_expense_type/1 returns a expense_type changeset" do
      expense_type = expense_type_fixture()
      assert %Ecto.Changeset{} = ExpenseTypes.change_expense_type(expense_type)
    end
  end
end
