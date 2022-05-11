defmodule FoxBank.Accounts do
  @moduledoc """
  Core context for user Accounts
  """
  import Ecto.Query

  alias FoxBank.Repo

  alias Commanded.Commands.ExecutionResult
  alias FoxBank.Core.Accounts.Bank
  alias FoxBank.Core.Accounts.Commands.{DeposityMoney, WithdrawMoney}
  alias FoxBank.Core.Accounts.Projections.AccountEntry

  @spec deposity_money(Bank.account_number(), Bank.amount()) ::
          {:ok, ExecutionResult.t()} | {:error, term()}
  def deposity_money(acc_id, amount) do
    %DeposityMoney{account_id: acc_id, amount: amount}
    |> FoxBank.CommandedApplication.dispatch(returning: :execution_result)
  end

  @spec withdraw_money(Bank.account_number(), Bank.amount()) ::
          {:ok, ExecutionResult.t()} | {:error, term()}
  def withdraw_money(acc_id, amount) do
    %WithdrawMoney{account_id: acc_id, amount: amount}
    |> FoxBank.CommandedApplication.dispatch(returning: :execution_result)
  end

  # @spec send_money(Bank.account_number(), Bank.account_number(), Bank.amount()) :: {:ok, ExecutionResult.t()} | {:error, term()}
  # def send_money(from_acc_id, to_acc_id, amount) do

  # end

  @spec view_balance(Bank.account_number()) :: Bank.amount()
  def view_balance(account) do
    Repo.one(
      from e in AccountEntry,
        where: e.account == ^account,
        select: sum(e.debit) - sum(e.credit)
    )
  end
end
