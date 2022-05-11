defmodule FoxBank.Core.Router do
  use Commanded.Commands.Router

  alias FoxBank.Core.Accounts.Commands

  dispatch(
    [
      Commands.DeposityMoney,
      Commands.WithdrawMoney
    ],
    to: FoxBank.Core.Accounts.Account,
    identity: :account_id
  )
end
