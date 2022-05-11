defmodule FoxBank.Core.Accounts.Commands.DeposityMoney do
  @moduledoc """
    Deposit money into an account
  """

  alias FoxBank.Core.Accounts.Bank

  @type t :: %__MODULE__{
          account_id: Bank.account_number(),
          amount: Bank.amount()
        }

  defstruct [:account_id, :amount]
end
