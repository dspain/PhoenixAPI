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
end
