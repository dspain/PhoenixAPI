defmodule MarketApiWeb.MarketControllerTest do
  use MarketApiWeb.ConnCase

  alias MarketApi.API
  alias MarketApi.API.Market

  @create_attrs %{name: "some name", phone: "some phone"}
  @update_attrs %{name: "some updated name", phone: "some updated phone"}
  @invalid_attrs %{name: nil, phone: nil}

  def fixture(:market) do
    {:ok, market} = API.create_market(@create_attrs)
    market
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all markets", %{conn: conn} do
      conn = get conn, market_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create market" do
    test "renders market when data is valid", %{conn: conn} do
      conn = post conn, market_path(conn, :create), market: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, market_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some name",
        "phone" => "some phone"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, market_path(conn, :create), market: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update market" do
    setup [:create_market]

    test "renders market when data is valid", %{conn: conn, market: %Market{id: id} = market} do
      conn = put conn, market_path(conn, :update, market), market: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, market_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some updated name",
        "phone" => "some updated phone"}
    end

    test "renders errors when data is invalid", %{conn: conn, market: market} do
      conn = put conn, market_path(conn, :update, market), market: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete market" do
    setup [:create_market]

    test "deletes chosen market", %{conn: conn, market: market} do
      conn = delete conn, market_path(conn, :delete, market)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, market_path(conn, :show, market)
      end
    end
  end

  defp create_market(_) do
    market = fixture(:market)
    {:ok, market: market}
  end
end
