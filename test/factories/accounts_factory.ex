defmodule FoxBank.AccountsFactory do
  @moduledoc false
  defmacro __using__(_opts) do
    quote do
      # alias FoxBankWeb.Accounts

      # def university_factory do
      #   %University{
      #     id: id(),
      #     name: "UNIP",
      #     logo_url: "https://www.tryimg.com/u/2019/04/16/unip.png"
      #   }
      # end
    end
  end
end
