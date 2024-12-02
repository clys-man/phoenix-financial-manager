defmodule FinancialManagerWeb.DashboardLive.Index do
  import Ecto.Query, warn: false

  alias FinancialManager.Repo

  use FinancialManagerWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    user_id = socket.assigns.current_user.id

    current_month_start = Date.beginning_of_month(Date.utc_today())
    current_month_end = Date.end_of_month(Date.utc_today())

    transactions_query =
      from(
        t in fragment(
          """
          (
            SELECT i.id id, i.description description, i.date date, 'income' type, i.amount amount
            FROM incomes i
            WHERE i.user_id = ? AND i.date >= ? AND i.date <= ?
            UNION ALL
            SELECT e.id id, e.description description, e.date date, 'expense' type, e.amount amount
            FROM expenses e
            WHERE e.user_id = ? AND e.date >= ? AND e.date <= ?
          )
          """,
          ^user_id,
          ^current_month_start,
          ^current_month_end,
          ^user_id,
          ^current_month_start,
          ^current_month_end
        ),
        order_by: [desc: t.date],
        select: %{
          id: t.id,
          description: t.description,
          date: t.date,
          type: t.type,
          amount: t.amount
        }
      )

    transactions = Repo.all(transactions_query)

    total_incomes =
      transactions
      |> Enum.filter(&(&1.type == "income"))
      |> Enum.reduce(Decimal.new(0), fn t, acc -> Decimal.add(acc, t.amount) end)

    total_expenses =
      transactions
      |> Enum.filter(&(&1.type == "expense"))
      |> Enum.reduce(Decimal.new(0), fn t, acc -> Decimal.add(acc, t.amount) end)

    balance = Decimal.sub(total_incomes, total_expenses)

    chart_data =
      transactions
      |> Enum.group_by(& &1.date)
      |> Enum.map(fn {date, trans} ->
        income =
          trans
          |> Enum.filter(&(&1.type == "income"))
          |> Enum.reduce(Decimal.new(0), fn t, acc -> Decimal.add(acc, t.amount) end)

        expense =
          trans
          |> Enum.filter(&(&1.type == "expense"))
          |> Enum.reduce(Decimal.new(0), fn t, acc -> Decimal.add(acc, t.amount) end)

        %{date: date, income: Decimal.to_float(income), expense: Decimal.to_float(expense)}
      end)

    socket =
      assign(socket,
        transactions: transactions,
        points: chart_data,
        total_incomes: total_incomes,
        total_expenses: total_expenses,
        balance: balance
      )

    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.header>Dashboard</.header>

    <div class="grid grid-cols-3 gap-4 my-4">
      <div class="bg-white p-4 rounded shadow">
        <h3 class="text-lg font-bold text-indigo-600">Balance</h3>
        <p class="text-2xl font-semibold"><%= @balance %> USD</p>
      </div>
      <div class="bg-white p-4 rounded shadow">
        <h3 class="text-lg font-bold text-indigo-600">Total Income</h3>
        <p class="text-2xl font-semibold"><%= @total_incomes %> USD</p>
      </div>
      <div class="bg-white p-4 rounded shadow">
        <h3 class="text-lg font-bold text-indigo-600">Total Expenses</h3>
        <p class="text-2xl font-semibold"><%= @total_expenses %> USD</p>
      </div>
    </div>

    <div class="bg-white p-6 rounded shadow my-6">
      <h3 class="text-lg font-semibold mb-4">Transactions by Day</h3>
      <canvas id="my-chart" phx-hook="ChartJS" data-points={Jason.encode!(@points)}></canvas>
    </div>

    <h2 class="text-xl font-bold mt-8 mb-4">Transactions</h2>
    <.table
      id="transactions"
      rows={@transactions}
      row_click={
        fn transaction ->
          if transaction.type == "income" do
            JS.navigate(~p"/incomes/#{transaction.id}")
          else
            JS.navigate(~p"/expenses/#{transaction.id}")
          end
        end
      }
    >
      <:col :let={transaction} label="Description">
        <%= transaction.description %>
      </:col>
      <:col :let={transaction} label="Date">
        <%= transaction.date %>
      </:col>
      <:col :let={transaction} label="Type">
        <%= if transaction.type == "income", do: "Income", else: "Expense" %>
      </:col>
      <:col :let={transaction} label="Amount">
        <%= Decimal.to_string(transaction.amount) %> USD
      </:col>
    </.table>
    """
  end
end

