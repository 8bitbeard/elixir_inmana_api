defmodule InmanaWeb.SuppliesViewTest do
  use InmanaWeb.ConnCase, async: true

  import Inmana.Factory
  import Phoenix.View

  alias Inmana.Supply
  alias InmanaWeb.SuppliesView

  describe "render/2" do
    test "renders create.json" do
      supply = build(:supply)

      response = render(SuppliesView, "create.json", supply: supply)

      assert %{
               message: "Supply created!",
               supply: %Supply{
                 id: _id,
                 description: "Factory Supply",
                 responsible: "Factory User"
               }
             } = response
    end
  end
end
