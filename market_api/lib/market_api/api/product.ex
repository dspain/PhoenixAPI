defmodule MarketApi.API.Product do
  use Ecto.Schema
  import Ecto.Changeset
  alias MarketApi.API.Product


  schema "products" do
    field :barcode, :string
    field :image, :string
    field :name, :string
    field :price, :decimal
    field :market_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Product{} = product, attrs) do
    product
    |> cast(attrs, [:name, :barcode, :image, :price])
    |> validate_required([:name, :barcode, :image, :price])
  end
end
