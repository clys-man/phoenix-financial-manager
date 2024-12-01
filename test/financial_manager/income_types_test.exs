defmodule FinancialManager.IncomeTypesTest do
  use FinancialManager.DataCase

  alias FinancialManager.IncomeTypes

  describe "income_types" do
    alias FinancialManager.IncomeTypes.IncomeType

    import FinancialManager.IncomeTypesFixtures

    @invalid_attrs %{name: nil}

    test "list_income_types/0 returns all income_types" do
      income_type = income_type_fixture()
      assert IncomeTypes.list_income_types() == [income_type]
    end

    test "get_income_type!/1 returns the income_type with given id" do
      income_type = income_type_fixture()
      assert IncomeTypes.get_income_type!(income_type.id) == income_type
    end

    test "create_income_type/1 with valid data creates a income_type" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %IncomeType{} = income_type} = IncomeTypes.create_income_type(valid_attrs)
      assert income_type.name == "some name"
    end

    test "create_income_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = IncomeTypes.create_income_type(@invalid_attrs)
    end

    test "update_income_type/2 with valid data updates the income_type" do
      income_type = income_type_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %IncomeType{} = income_type} = IncomeTypes.update_income_type(income_type, update_attrs)
      assert income_type.name == "some updated name"
    end

    test "update_income_type/2 with invalid data returns error changeset" do
      income_type = income_type_fixture()
      assert {:error, %Ecto.Changeset{}} = IncomeTypes.update_income_type(income_type, @invalid_attrs)
      assert income_type == IncomeTypes.get_income_type!(income_type.id)
    end

    test "delete_income_type/1 deletes the income_type" do
      income_type = income_type_fixture()
      assert {:ok, %IncomeType{}} = IncomeTypes.delete_income_type(income_type)
      assert_raise Ecto.NoResultsError, fn -> IncomeTypes.get_income_type!(income_type.id) end
    end

    test "change_income_type/1 returns a income_type changeset" do
      income_type = income_type_fixture()
      assert %Ecto.Changeset{} = IncomeTypes.change_income_type(income_type)
    end
  end
end
