defmodule FoxBank.CommandedApplication do
  @moduledoc false
  use Commanded.Application, otp_app: :fox_bank

  router(FoxBank.Core.Router)
end
