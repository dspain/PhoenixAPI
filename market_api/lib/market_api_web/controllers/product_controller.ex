defmodule MarketApiWeb.ProductController do
  use MarketApiWeb, :controller

  alias MarketApi.API
  alias MarketApi.API.Product

  action_fallback MarketApiWeb.FallbackController

  def index(conn, _params) do
    products = API.list_products()
    render(conn, "index.json", products: products)
  end

  def create(conn, %{"product" => product_params}) do
    with {:ok, %Product{} = product} <- API.create_product(product_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", product_path(conn, :show, product))
      |> render("show.json", product: product)
    end
  end

  def show(conn, %{"id" => id}) do
    product = API.get_product!(id)
    render(conn, "show.json", product: product)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = API.get_product!(id)

    with {:ok, %Product{} = product} <- API.update_product(product, product_params) do
      render(conn, "show.json", product: product)
    end
  end

  def delete(conn, %{"id" => id}) do
    product = API.get_product!(id)
    with {:ok, %Product{}} <- API.delete_product(product) do
      send_resp(conn, :no_content, "")
    end
  end
end
