defmodule FoxBank.Repo do
  use Ecto.Repo,
    otp_app: :fox_bank,
    adapter: Ecto.Adapters.Postgres
end
