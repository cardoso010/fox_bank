defmodule FoxBank.InMemoryEventStoreCase do
  @moduledoc false
  use ExUnit.CaseTemplate

  # alias Commanded.EventStore.Adapters.InMemory

  setup do
    {:ok, _apps} = Application.ensure_all_started(:fox_bank)

    on_exit(fn ->
      :ok = Application.stop(:fox_bank)
    end)
  end
end
