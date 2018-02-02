defmodule MarketApi.API.Market do
  use Ecto.Schema
  import Ecto.Changeset
  alias MarketApi.API.Market


  schema "markets" do
    field :name, :string
    field :phone, :string

    timestamps()
  end

  @doc false
  def changeset(%Market{} = market, attrs) do
    market
    |> cast(attrs, [:name, :phone])
    |> validate_required([:name, :phone])
  end
end
