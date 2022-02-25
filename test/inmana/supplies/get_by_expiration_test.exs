defmodule Inmana.Supplies.GetByExpirationTest do
  use Inmana.DataCase, async: true

  import Inmana.Factory

  alias Inmana.{Restaurant, Supply}
  alias Inmana.Supplies.GetByExpiration

  describe "call/0" do
    test "returns an map of supplies" do
      build(:supply)

      now = Date.utc_today()

      response = GetByExpiration.call()

      assert %{
               "factory_restaurant@example.com" => [
                 %Supply{
                   description: "Factory Supply",
                   expiration_date: ^now,
                   responsible: "Factory User",
                   restaurant: %Restaurant{
                     email: "factory_restaurant@example.com",
                     name: "Factory Restaurant"
                   }
                 }
               ]
             } = response
    end
  end
end
