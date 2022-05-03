defmodule FoxBank.Factory do
  @moduledoc false
  use ExMachina.Ecto, repo: FoxBank.Repo

  use FoxBank.AccountsFactory

  def id, do: Ecto.UUID.generate()
end
