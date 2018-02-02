defmodule MarketApiWeb.MarketView do
  use MarketApiWeb, :view
  alias MarketApiWeb.MarketView

  def render("index.json", %{markets: markets}) do
    %{data: render_many(markets, MarketView, "market.json")}
  end

  def render("show.json", %{market: market}) do
    %{data: render_one(market, MarketView, "market.json")}
  end

  def render("market.json", %{market: market}) do
    %{id: market.id,
      name: market.name,
      phone: market.phone}
  end
end
