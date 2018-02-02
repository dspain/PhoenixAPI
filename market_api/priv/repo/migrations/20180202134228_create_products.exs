defmodule MarketApi.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :barcode, :string
      add :image, :string
      add :price, :decimal
      add :market_id, references(:markets, on_delete: :nothing)

      timestamps()
    end

    create index(:products, [:market_id])
  end
end
