defmodule FoxBankWeb.PageController do
  use FoxBankWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
