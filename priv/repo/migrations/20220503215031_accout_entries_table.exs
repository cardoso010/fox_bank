defmodule FoxBank.Repo.Migrations.AccoutEntriesTable do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:account_entries) do
      add :journal_entry_uuid, :binary_id
      add :account, :string
      add :credit, :integer
      add :debit, :integer

      timestamps(type: :naive_datetime_usec)
    end
  end
end
