defmodule MarketApiWeb.MarketController do
  use MarketApiWeb, :controller

  alias MarketApi.API
  alias MarketApi.API.Market

  action_fallback MarketApiWeb.FallbackController

  def index(conn, _params) do
    markets = API.list_markets()
    render(conn, "index.json", markets: markets)
  end

  def create(conn, %{"market" => market_params}) do
    with {:ok, %Market{} = market} <- API.create_market(market_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", market_path(conn, :show, market))
      |> render("show.json", market: market)
    end
  end

  def show(conn, %{"id" => id}) do
    market = API.get_market!(id)
    render(conn, "show.json", market: market)
  end

  def update(conn, %{"id" => id, "market" => market_params}) do
    market = API.get_market!(id)

    with {:ok, %Market{} = market} <- API.update_market(market, market_params) do
      render(conn, "show.json", market: market)
    end
  end

  def delete(conn, %{"id" => id}) do
    market = API.get_market!(id)
    with {:ok, %Market{}} <- API.delete_market(market) do
      send_resp(conn, :no_content, "")
    end
  end
end
