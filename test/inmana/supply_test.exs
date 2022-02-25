defmodule Inmana.SupplyTest do
  use Inmana.DataCase, async: true

  import Inmana.Factory

  alias Ecto.Changeset
  alias Inmana.Supply

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:supply_params)

      response = Supply.changeset(params)

      assert %Changeset{
               changes: %{
                 description: "Factory Supply",
                 expiration_date: ~D[2022-12-12],
                 responsible: "Factory User"
               },
               valid?: true
             } = response
    end

    test "when there are invalid params, returns a invalid changeset" do
      params = build(:invalid_supply_params)

      response = Supply.changeset(params)

      expected_response = %{
        description: ["should be at least 3 character(s)"],
        expiration_date: ["can't be blank"],
        responsible: ["should be at least 3 character(s)"],
        restaurant_id: ["can't be blank"]
      }

      assert %Changeset{valid?: false} = response
      assert errors_on(response) == expected_response
    end
  end
end
