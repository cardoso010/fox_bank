defmodule FoxBank.Core.Accounts.Account do
  @moduledoc "Account Aggregate"

  alias FoxBank.Core.Accounts.Bank
  alias FoxBank.Core.Accounts.Commands.{DeposityMoney, WithdrawMoney}

  alias FoxBank.Core.Accounts.Events.{
    AccountOpened,
    JournalEntryCreated,
    MoneyDeposited,
    MoneyWithdrawn
  }

  @type t() :: %__MODULE__{
          id: Bank.account_number(),
          balance: Bank.amount()
        }

  defstruct [:id, balance: 0]

  @type event() :: struct()
  @type cmd() :: struct()

  @spec execute(t(), cmd()) :: [event()] | {:error, term}
  def execute(%__MODULE__{}, %DeposityMoney{account_id: "000-000"}),
    do: {:error, :unable_to_create_account}

  def execute(%__MODULE__{id: nil}, %DeposityMoney{} = cmd) do
    [
      %AccountOpened{
        account_id: cmd.account_id
      },
      %MoneyDeposited{
        account_id: cmd.account_id,
        amount: cmd.amount
      },
      %JournalEntryCreated{
        journal_entry_uuid: Ecto.UUID.generate(),
        account: cmd.account_id,
        debit: %{"#{cmd.account_id}" => cmd.amount},
        credit: %{"000-000" => cmd.amount}
      }
    ]
  end

  def execute(%__MODULE__{}, %DeposityMoney{} = cmd) do
    [
      %MoneyDeposited{
        account_id: cmd.account_id,
        amount: cmd.amount
      },
      %JournalEntryCreated{
        journal_entry_uuid: Ecto.UUID.generate(),
        account: cmd.account_id,
        debit: %{"#{cmd.account_id}" => cmd.amount},
        credit: %{"000-000" => cmd.amount}
      }
    ]
  end

  def execute(%__MODULE__{balance: balance}, %WithdrawMoney{amount: amount})
      when balance < amount,
      do: {:error, :insufficient_balance}

  def execute(%__MODULE__{}, %WithdrawMoney{} = cmd) do
    [
      %MoneyWithdrawn{
        account_id: cmd.account_id,
        amount: cmd.amount
      },
      %JournalEntryCreated{
        journal_entry_uuid: Ecto.UUID.generate(),
        account: cmd.account_id,
        debit: %{"000-000" => cmd.amount},
        credit: %{"#{cmd.account_id}" => cmd.amount}
      }
    ]
  end

  def execute(%__MODULE__{id: nil}, _cmd), do: {:error, :not_found}

  @spec apply(t(), event()) :: t()
  def apply(state, %AccountOpened{} = event) do
    %{state | id: event.account_id}
  end

  def apply(state, %MoneyDeposited{} = event) do
    %{state | balance: state.balance + event.amount}
  end

  def apply(state, %MoneyWithdrawn{} = event) do
    %{state | balance: state.balance - event.amount}
  end

  def apply(state, %JournalEntryCreated{}), do: state
end
