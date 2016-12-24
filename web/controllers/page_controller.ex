defmodule SneakerfansElixir.PageController do
  use SneakerfansElixir.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
