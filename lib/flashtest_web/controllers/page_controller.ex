defmodule FlashtestWeb.PageController do
  use FlashtestWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
