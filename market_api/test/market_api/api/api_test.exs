defmodule MarketApi.APITest do
  use MarketApi.DataCase

  alias MarketApi.API

  describe "markets" do
    alias MarketApi.API.Market

    @valid_attrs %{name: "some name", phone: "some phone"}
    @update_attrs %{name: "some updated name", phone: "some updated phone"}
    @invalid_attrs %{name: nil, phone: nil}

    def market_fixture(attrs \\ %{}) do
      {:ok, market} =
        attrs
        |> Enum.into(@valid_attrs)
        |> API.create_market()

      market
    end

    test "list_markets/0 returns all markets" do
      market = market_fixture()
      assert API.list_markets() == [market]
    end

    test "get_market!/1 returns the market with given id" do
      market = market_fixture()
      assert API.get_market!(market.id) == market
    end

    test "create_market/1 with valid data creates a market" do
      assert {:ok, %Market{} = market} = API.create_market(@valid_attrs)
      assert market.name == "some name"
      assert market.phone == "some phone"
    end

    test "create_market/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = API.create_market(@invalid_attrs)
    end

    test "update_market/2 with valid data updates the market" do
      market = market_fixture()
      assert {:ok, market} = API.update_market(market, @update_attrs)
      assert %Market{} = market
      assert market.name == "some updated name"
      assert market.phone == "some updated phone"
    end

    test "update_market/2 with invalid data returns error changeset" do
      market = market_fixture()
      assert {:error, %Ecto.Changeset{}} = API.update_market(market, @invalid_attrs)
      assert market == API.get_market!(market.id)
    end

    test "delete_market/1 deletes the market" do
      market = market_fixture()
      assert {:ok, %Market{}} = API.delete_market(market)
      assert_raise Ecto.NoResultsError, fn -> API.get_market!(market.id) end
    end

    test "change_market/1 returns a market changeset" do
      market = market_fixture()
      assert %Ecto.Changeset{} = API.change_market(market)
    end
  end

  describe "products" do
    alias MarketApi.API.Product

    @valid_attrs %{barcode: "some barcode", image: "some image", name: "some name", price: "120.5"}
    @update_attrs %{barcode: "some updated barcode", image: "some updated image", name: "some updated name", price: "456.7"}
    @invalid_attrs %{barcode: nil, image: nil, name: nil, price: nil}

    def product_fixture(attrs \\ %{}) do
      {:ok, product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> API.create_product()

      product
    end

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert API.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert API.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      assert {:ok, %Product{} = product} = API.create_product(@valid_attrs)
      assert product.barcode == "some barcode"
      assert product.image == "some image"
      assert product.name == "some name"
      assert product.price == Decimal.new("120.5")
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = API.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      assert {:ok, product} = API.update_product(product, @update_attrs)
      assert %Product{} = product
      assert product.barcode == "some updated barcode"
      assert product.image == "some updated image"
      assert product.name == "some updated name"
      assert product.price == Decimal.new("456.7")
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = API.update_product(product, @invalid_attrs)
      assert product == API.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = API.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> API.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = API.change_product(product)
    end
  end
end
