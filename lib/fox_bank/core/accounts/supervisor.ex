defmodule FoxBank.Core.Accounts.Supervisor do
  use Supervisor

  alias FoxBank.Core.Accounts

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def init(_arg) do
    Supervisor.init(
      [
        Accounts.Projectors.AccountEntry
      ],
      strategy: :one_for_one
    )
  end
end
