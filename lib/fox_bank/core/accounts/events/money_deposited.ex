defmodule FoxBank.Core.Accounts.Events.MoneyDeposited do
  @moduledoc """
    Deposit money into an account
  """

  alias FoxBank.Core.Accounts.Bank

  @type t :: %__MODULE__{
          account_id: Bank.account_number(),
          amount: Bank.amount()
        }

  @derive Jason.Encoder
  defstruct [:account_id, :amount]
end
