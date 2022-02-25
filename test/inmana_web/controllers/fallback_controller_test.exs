defmodule InmanaWeb.FallbackControllerTest do
  use InmanaWeb.ConnCase, async: true

  alias InmanaWeb.FallbackController

  describe "call/2" do
    test "when all params are valid, creates the restaurant", %{conn: conn} do
      response = FallbackController.call(conn, {:error, %{result: "test", status: :bad_request}})

      assert json_response(response, 400) == %{"message" => "test"}
    end
  end
end
