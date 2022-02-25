defmodule Inmana.Restaurants.GetTest do
  use Inmana.DataCase, async: true

  import Inmana.Factory

  alias Inmana.{Restaurant, Supply}
  alias Inmana.Supplies.Get

  describe "call/1" do
    test "when all params are valid, create a new supply" do
      restaurant_params = build(:restaurant_params)

      {:ok, %Restaurant{id: id}} = Inmana.create_restaurant(restaurant_params)

      supply_params = build(:supply_params, %{restaurant_id: id})

      {:ok, %Supply{id: uuid}} = Inmana.create_supply(supply_params)

      response = Get.call(uuid)

      assert {:ok,
              %Supply{
                description: "Factory Supply",
                expiration_date: ~D[2022-12-12],
                responsible: "Factory User",
                restaurant_id: ^id
              }} = response
    end

    test "when there are invalid parameters, returns an error" do
      uuid = Faker.UUID.v4()

      response = Get.call(uuid)

      expected_response = {:error, %{result: "Supply not found", status: :not_found}}

      assert response == expected_response
    end
  end
end
