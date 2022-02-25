defmodule Inmana.Supplies.CreateTest do
  use Inmana.DataCase, async: true

  import Inmana.Factory

  alias Inmana.{Restaurant, Supply}
  alias Inmana.Supplies.Create

  describe "call/1" do
    test "when all params are valid, create a new supply" do
      restaurant_params = build(:restaurant_params)

      {:ok, %Restaurant{id: id}} = Inmana.create_restaurant(restaurant_params)

      supply_params = build(:supply_params, %{restaurant_id: id})

      response = Create.call(supply_params)

      assert {:ok,
              %Supply{
                description: "Factory Supply",
                expiration_date: ~D[2022-12-12],
                responsible: "Factory User",
                restaurant_id: ^id
              }} = response
    end

    test "when there are invalid parameters, returns an error" do
      restaurant_params = build(:restaurant_params)

      {:ok, %Restaurant{}} = Inmana.create_restaurant(restaurant_params)

      supply_params = build(:invalid_supply_params)

      response = Create.call(supply_params)

      expected_response = %{
        description: ["should be at least 3 character(s)"],
        expiration_date: ["can't be blank"],
        responsible: ["should be at least 3 character(s)"],
        restaurant_id: ["can't be blank"]
      }

      assert {:error, %{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end
  end
end
