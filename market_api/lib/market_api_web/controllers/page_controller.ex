defmodule MarketApiWeb.PageController do
  use MarketApiWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
