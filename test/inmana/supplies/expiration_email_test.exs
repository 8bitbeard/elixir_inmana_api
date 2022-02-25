defmodule Inmana.Supplies.ExpirationEmailTest do
  use Inmana.DataCase, async: true

  import Inmana.Factory

  alias Bamboo.Email
  alias Inmana.Supplies.ExpirationEmail

  describe "create/2" do
    test "when parameters are valid, create a new email" do
      supply = build(:supply)

      response = ExpirationEmail.create("mocktest@example.com", [supply])

      assert %Email{
        from: "app@inmana.com",
        html_body: "<p>TESTE DE HTML</p>",
        subject: "Supplies that are about to expire",
        to: "mocktest@example.com"
      } = response
    end
  end
end
