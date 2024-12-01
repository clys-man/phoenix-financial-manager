defmodule FinancialManager.IncomesTest do
  use FinancialManager.DataCase

  alias FinancialManager.Incomes

  describe "incomes" do
    alias FinancialManager.Incomes.Income

    import FinancialManager.IncomesFixtures

    @invalid_attrs %{date: nil, description: nil, amount: nil}

    test "list_incomes/0 returns all incomes" do
      income = income_fixture()
      assert Incomes.list_incomes() == [income]
    end

    test "get_income!/1 returns the income with given id" do
      income = income_fixture()
      assert Incomes.get_income!(income.id) == income
    end

    test "create_income/1 with valid data creates a income" do
      valid_attrs = %{date: ~D[2024-11-30], description: "some description", amount: "120.5"}

      assert {:ok, %Income{} = income} = Incomes.create_income(valid_attrs)
      assert income.date == ~D[2024-11-30]
      assert income.description == "some description"
      assert income.amount == Decimal.new("120.5")
    end

    test "create_income/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Incomes.create_income(@invalid_attrs)
    end

    test "update_income/2 with valid data updates the income" do
      income = income_fixture()
      update_attrs = %{date: ~D[2024-12-01], description: "some updated description", amount: "456.7"}

      assert {:ok, %Income{} = income} = Incomes.update_income(income, update_attrs)
      assert income.date == ~D[2024-12-01]
      assert income.description == "some updated description"
      assert income.amount == Decimal.new("456.7")
    end

    test "update_income/2 with invalid data returns error changeset" do
      income = income_fixture()
      assert {:error, %Ecto.Changeset{}} = Incomes.update_income(income, @invalid_attrs)
      assert income == Incomes.get_income!(income.id)
    end

    test "delete_income/1 deletes the income" do
      income = income_fixture()
      assert {:ok, %Income{}} = Incomes.delete_income(income)
      assert_raise Ecto.NoResultsError, fn -> Incomes.get_income!(income.id) end
    end

    test "change_income/1 returns a income changeset" do
      income = income_fixture()
      assert %Ecto.Changeset{} = Incomes.change_income(income)
    end
  end
end
