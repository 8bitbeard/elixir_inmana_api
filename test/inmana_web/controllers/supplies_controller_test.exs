defmodule InmanaWeb.SuppliesControllerTest do
  use InmanaWeb.ConnCase, async: true

  import Inmana.Factory

  describe "create/2" do
    test "when all params are valid, creates the restaurant", %{conn: conn} do
      restaurant = build(:restaurant)

      params = build(:supply_params, %{restaurant_id: restaurant.id})

      response =
        conn
        |> post(Routes.supplies_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "Supply created!",
               "supply" => %{
                 "id" => _id,
                 "description" => "Factory Supply",
                 "expiration_date" => "2022-12-12",
                 "responsible" => "Factory User"
               }
             } = response
    end

    test "when the params are invalid, returns an error", %{conn: conn} do
      restaurant = build(:restaurant)

      params = build(:invalid_supply_params)

      response =
        conn
        |> post(Routes.supplies_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{
          "description" => ["should be at least 3 character(s)"],
          "expiration_date" => ["can't be blank"],
          "responsible" => ["should be at least 3 character(s)"],
          "restaurant_id" => ["can't be blank"]
        }
      }

      assert response == expected_response
    end
  end

  describe "show/2" do
    test "when all params are valid, creates the restaurant", %{conn: conn} do
      supply = build(:supply)

      response =
        conn
        |> get(Routes.supplies_path(conn, :show, supply.id))
        |> json_response(:ok)

      assert %{
               "supply" => %{
                 "id" => _id,
                 "description" => "Factory Supply",
                 "responsible" => "Factory User"
               }
             } = response
    end

    test "when the params are invalid, returns an error", %{conn: conn} do
      uuid = Faker.UUID.v4()

      response =
        conn
        |> get(Routes.supplies_path(conn, :show, uuid))
        |> json_response(:not_found)

      expected_response = %{"message" => "Supply not found"}

      assert response == expected_response
    end
  end
end
