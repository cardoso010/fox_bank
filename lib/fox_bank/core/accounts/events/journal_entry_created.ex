defmodule FoxBank.Core.Accounts.Events.JournalEntryCreated do
  @moduledoc false

  alias FoxBank.Core.Accounts.Bank

  @type t :: %__MODULE__{
          journal_entry_uuid: binary(),
          account: Bank.account_number(),
          debit: Bank.account_entries(),
          credit: Bank.account_entries()
        }

  @derive Jason.Encoder
  defstruct [:journal_entry_uuid, :account, :debit, :credit]
end
