defmodule FoxBank.Core.Accounts.Events.AccountOpened do
  @moduledoc false

  alias FoxBank.Core.Accounts.Bank

  @type t :: %__MODULE__{
          account_id: Bank.account_number()
        }

  @derive Jason.Encoder
  defstruct [:account_id]
end
