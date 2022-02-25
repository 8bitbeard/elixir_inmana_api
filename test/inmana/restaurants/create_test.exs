defmodule Inmana.Restaurants.CreateTest do
  use Inmana.DataCase, async: true

  import Inmana.Factory

  alias Inmana.Restaurant
  alias Inmana.Restaurants.Create

  describe "call/1" do
    test "when all params are valid, create a new supply" do
      restaurant_params = build(:restaurant_params)

      response = Create.call(restaurant_params)

      assert {:ok,
              %Restaurant{
                id: _id,
                name: "Factory Restaurant",
                email: "factory_restaurant@example.com"
              }} = response
    end

    test "when there are invalid parameters, returns an error" do
      restaurant_params = build(:invalid_restaurant_params)

      response = Create.call(restaurant_params)

      expected_response = %{
        email: ["has invalid format"],
        name: ["should be at least 2 character(s)"]
      }

      assert {:error, %{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end

    test "when there are already a restaurant with given email, returns an error" do
      restaurant_params = build(:restaurant_params)

      Inmana.create_restaurant(restaurant_params)

      response = Create.call(restaurant_params)

      expected_response = %{email: ["has already been taken"]}

      assert {:error, %{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end
  end
end
