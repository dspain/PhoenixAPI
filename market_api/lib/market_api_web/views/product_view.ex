defmodule MarketApiWeb.ProductView do
  use MarketApiWeb, :view
  alias MarketApiWeb.ProductView

  def render("index.json", %{products: products}) do
    %{data: render_many(products, ProductView, "product.json")}
  end

  def render("show.json", %{product: product}) do
    %{data: render_one(product, ProductView, "product.json")}
  end

  def render("product.json", %{product: product}) do
    %{id: product.id,
      name: product.name,
      barcode: product.barcode,
      image: product.image,
      price: product.price}
  end
end
