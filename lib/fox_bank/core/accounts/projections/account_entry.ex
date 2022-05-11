defmodule FoxBank.Core.Accounts.Projections.AccountEntry do
  @moduledoc """
  This module defines the AccountEntry schema.
  Used to model single account entries
  """

  use Ecto.Schema

  @type t() :: %{
          journal_entry_uuid: binary(),
          account: binary(),
          credit: integer(),
          debit: integer()
        }

  schema "account_entries" do
    field :journal_entry_uuid, :binary_id
    field :account, :string

    field :credit, :integer, default: 0
    field :debit, :integer, default: 0

    timestamps()
  end
end
