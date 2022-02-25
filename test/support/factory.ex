defmodule Inmana.Factory do
  use ExMachina.Ecto, repo: Inmana.Repo

  alias Faker.UUID

  def restaurant_params_factory do
    %{
      name: "Factory Restaurant",
      email: "factory_restaurant@example.com"
    }
  end

  def invalid_restaurant_params_factory do
    %{
      name: "F",
      email: "fa"
    }
  end

  def supply_params_factory do
    %{
      description: "Factory Supply",
      expiration_date: "2022-12-12",
      responsible: "Factory User",
      restaurant_id: UUID.v4()
    }
  end

  def invalid_supply_params_factory do
    %{
      description: "Fa",
      responsible: "Fa",
      expiration_date: "",
      restaurant_id: ""
    }
  end

  def restaurant_factory do
    restaurant_params = %{
      name: "Factory Restaurant",
      email: "factory_restaurant@example.com"
    }

    {:ok, %Inmana.Restaurant{} = restaurant} = Inmana.create_restaurant(restaurant_params)

    restaurant
  end

  def supply_factory do
    restaurant_params = %{
      name: "Factory Restaurant",
      email: "factory_restaurant@example.com"
    }

    {:ok, %Inmana.Restaurant{id: restaurant_id}} = Inmana.create_restaurant(restaurant_params)

    supply_params = %{
      description: "Factory Supply",
      expiration_date: Date.utc_today(),
      responsible: "Factory User",
      restaurant_id: restaurant_id
    }

    {:ok, %Inmana.Supply{} = supply} = Inmana.create_supply(supply_params)

    supply
  end
end
