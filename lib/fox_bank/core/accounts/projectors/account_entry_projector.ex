defmodule FoxBank.Core.Accounts.Projectors.AccountEntry do
  @moduledoc false
  use Commanded.Projections.Ecto,
    name: "Accounts.Projectors.AccountEntry",
    application: FoxBank.CommandedApplication,
    repo: FoxBank.Repo,
    consistency: :strong

  alias Ecto.Multi

  alias FoxBank.Core.Accounts.Projections.AccountEntry
  alias FoxBank.Core.Accounts.Events.JournalEntryCreated

  project(
    %JournalEntryCreated{} = evt,
    _metadata,
    fn multi ->
      Multi.insert(
        multi,
        :insert_account_entry,
        %AccountEntry{
          journal_entry_uuid: evt.journal_entry_uuid,
          account: evt.account,
          credit: get_amount(evt.account, evt.credit),
          debit: get_amount(evt.account, evt.debit)
        }
      )
    end
  )

  @spec get_amount(binary(), map()) :: integer()
  defp get_amount(account, map) do
    atom_account = String.to_atom(account)
    case Map.fetch(map, atom_account) do
     {:ok, amount} -> amount
      _ -> 0
    end
  end
end
